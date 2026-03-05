<#
    Updates a Visual C++ project file (.vcxproj) by adding all .h files from the specified 
    include directory and all .cpp files from the specified source directory.
#>

function Invoke-VcxprojUpdate {
    param(
        [Parameter(Mandatory = $true)]
        [string]$ProjectPath,

        [Parameter(Mandatory = $true)]
        [string]$IncludeDir,

        [Parameter(Mandatory = $true)]
        [string]$SourceDir
    )

    $ErrorActionPreference = "Stop"

    $PRE_COMPILE_FILES = @('StdAfx.h')

    $resolvedProjectPath = (Resolve-Path -LiteralPath $ProjectPath).Path
    $resolvedIncludeDir = (Resolve-Path -LiteralPath $IncludeDir).Path
    $resolvedSourceDir = (Resolve-Path -LiteralPath $SourceDir).Path

    if (-not (Test-Path -LiteralPath $resolvedProjectPath -PathType Leaf)) {
        throw "Project file not found: $ProjectPath"
    }

    if (-not (Test-Path -LiteralPath $resolvedIncludeDir -PathType Container)) {
        throw "Include directory not found: $IncludeDir"
    }

    if (-not (Test-Path -LiteralPath $resolvedSourceDir -PathType Container)) {
        throw "Source directory not found: $SourceDir"
    }

    [xml]$project = Get-Content -LiteralPath $resolvedProjectPath

    # Get namespace
    $ns = New-Object System.Xml.XmlNamespaceManager($project.NameTable)
    $ns.AddNamespace("ms", "http://schemas.microsoft.com/developer/msbuild/2003")

    # Remove existing ClInclude and ClCompile items
    $itemGroups = $project.SelectNodes("//ms:ItemGroup", $ns)
    foreach ($group in $itemGroups) {
        $toRemove = @()
        foreach ($child in $group.ChildNodes) {
            if ($child.Name -eq "ClInclude" -or $child.Name -eq "ClCompile") {
                $toRemove += $child
            }
        }
        foreach ($node in $toRemove) {
            $group.RemoveChild($node) | Out-Null
        }
    }

    # Remove empty ItemGroup elements
    $emptyItemGroups = $project.SelectNodes("//ms:ItemGroup[not(*) or not(node()[normalize-space()])]", $ns)
    foreach ($emptyGroup in $emptyItemGroups) {
        $emptyGroup.ParentNode.RemoveChild($emptyGroup) | Out-Null
    }

    # Get project directory for relative path calculation
    $projectDir = Split-Path -Parent $resolvedProjectPath

    # Create new ItemGroup for headers
    $headerGroup = $project.CreateElement("ItemGroup", $project.DocumentElement.NamespaceURI)
    $headerFiles = Get-ChildItem -Path $resolvedIncludeDir -Filter *.h -Recurse | Sort-Object FullName
    if ($headerFiles) {
        foreach ($file in $headerFiles) {
            $relativePath = $file.FullName.Substring($projectDir.Length + 1)
            $include = $project.CreateElement("ClInclude", $project.DocumentElement.NamespaceURI)
            $include.SetAttribute("Include", $relativePath)
            $headerGroup.AppendChild($include) | Out-Null
        }
        $project.DocumentElement.AppendChild($headerGroup) | Out-Null
    }

    # Create new ItemGroup for source files
    $sourceGroup = $project.CreateElement("ItemGroup", $project.DocumentElement.NamespaceURI)
    $sourceFiles = Get-ChildItem -Path $resolvedSourceDir -Filter *.cpp -Recurse | Sort-Object FullName
    if ($sourceFiles) {
        foreach ($file in $sourceFiles) {
            $relativePath = $file.FullName.Substring($projectDir.Length + 1)
            $compile = $project.CreateElement("ClCompile", $project.DocumentElement.NamespaceURI)
            $compile.SetAttribute("Include", $relativePath)
        
            # Check if this file needs precompiled header
            $correspondingHeader = $file.BaseName + ".h"
        
            if ($PRE_COMPILE_FILES -contains $correspondingHeader) {
                $pchElement = $project.CreateElement("PrecompiledHeader", $project.DocumentElement.NamespaceURI)
                $pchElement.InnerText = "Create"
                $compile.AppendChild($pchElement) | Out-Null
            }
        
            $sourceGroup.AppendChild($compile) | Out-Null
        }
        $project.DocumentElement.AppendChild($sourceGroup) | Out-Null
    }

    # Save with proper formatting
    $project.Save($resolvedProjectPath)
    Write-Host "Project updated: $resolvedProjectPath"
}