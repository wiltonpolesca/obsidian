. "$PSScriptRoot/InvokeRobocopy.ps1"
. "$PSScriptRoot/InvokeVcxprojUpdate.ps1"

function Invoke-CymdistArtifactsCreation {
    [CmdletBinding()]
    param(
        # Path to the local git folder (defaults to current folder)
        [Parameter(Mandatory = $false)]
        [string] $SrcFolder = (Join-Path (Get-Location).Path "../..")
    )

    $FME_FILES_GENERATOR_FOLDER = Join-Path $SrcFolder "FMEPluginsTools\FMEFilesGenerator"
    $FME_GENERATED_FILES_FOLDER = Join-Path $env:TEMP "fme-files"
    $CYMDIST_FILES = Join-Path $SrcFolder "Gateway\CYMDISTGIS"
    $CPP_FIRST_GEN = "cpp_files\FIRST_GEN\CYMDISTGIS"
    $CPP_SECOND_GEN = "cpp_files\SEC_GEN\CYMDISTGIS"

    # Files to preserve
    $PRESERVE_INC_FILES = @('CYMDistGIS.h', 'CYMDistWriter.h', 'StdAfx.h')
    $PRESERVE_SRC_FILES = @('CYMDistGIS.cpp', 'StdAfx.cpp')

    Write-Host "Delete output directory if it exists..." -ForegroundColor Cyan
    if (Test-Path "$FME_GENERATED_FILES_FOLDER") {
        Remove-Item "$FME_GENERATED_FILES_FOLDER" -Recurse -Force
    }

    Write-Host "Generating files (schema, JSON sources, and c++ files) using FMEFilesGenerator project..." -ForegroundColor Cyan
    $projectPath = Join-Path $FME_FILES_GENERATOR_FOLDER "FMEFilesGenerator.csproj"
    dotnet run --project $projectPath -v:diag -o $FME_GENERATED_FILES_FOLDER -s false
    
    if ($LASTEXITCODE -ne 0) {
        Write-Error "FMEFilesGenerator failed to run"
        exit 1
    }

    # Get the first subdirectory alphabetically (to get the generated code)
    $outputArtifactsFolder = Get-ChildItem -Path $FME_GENERATED_FILES_FOLDER -Directory | 
    Sort-Object Name | 
    Select-Object -First 1 -ExpandProperty FullName

    if (-not $outputArtifactsFolder) {
        Write-Error "No output directory found after running FMEFilesGenerator."
        exit 1
    }

    Write-Host "Using output directory: $outputArtifactsFolder" -ForegroundColor Green
    
    Write-Host "Cleaning up FirstGen include files..." -ForegroundColor Green
    $firstGenIncPath = Join-Path $CYMDIST_FILES "FirstGen\inc"
    if (Test-Path $firstGenIncPath) {
        Get-ChildItem -Path $firstGenIncPath -Recurse -File | 
        Where-Object { $_.Name -notin $PRESERVE_INC_FILES } | 
        Remove-Item -Force
    }

    Write-Host "Cleaning up SecondGen source files..." -ForegroundColor Green
    $secondGenSrcPath = Join-Path $CYMDIST_FILES "SecGen\src"
    if (Test-Path $secondGenSrcPath) {
        Get-ChildItem -Path $secondGenSrcPath -Recurse -File | 
        Where-Object { $_.Name -notin $PRESERVE_SRC_FILES } | 
        Remove-Item -Force
    }

    #  Copy generated c++ FirstGen files
    Write-Host "Copying generated c++ FirstGen files to the CYMDistGIS_FirstGen project..." -ForegroundColor Cyan
    $sourceIncPath = Join-Path $outputArtifactsFolder "$CPP_FIRST_GEN\inc"
    $destIncPath = Join-Path $CYMDIST_FILES "FirstGen\inc"
    Invoke-Robocopy -Source $sourceIncPath -Destination $destIncPath

    $sourceSrcPath = Join-Path $outputArtifactsFolder "$CPP_FIRST_GEN\src"
    $destSrcPath = Join-Path $CYMDIST_FILES "FirstGen\src"
    Invoke-Robocopy -Source $sourceSrcPath -Destination $destSrcPath

    # Copy generated c++ SecondGen files
    Write-Host "Copying generated c++ SecondGen files to the CYMDistGIS_SecondGen project..." -ForegroundColor Cyan
    $sourceIncPath = Join-Path $outputArtifactsFolder "$CPP_SECOND_GEN\inc"
    $destIncPath = Join-Path $CYMDIST_FILES "SecGen\inc"
    Invoke-Robocopy -Source $sourceIncPath -Destination $destIncPath

    $sourceSrcPath = Join-Path $outputArtifactsFolder "$CPP_SECOND_GEN\src"
    $destSrcPath = Join-Path $CYMDIST_FILES "SecGen\src"
    Invoke-Robocopy -Source $sourceSrcPath -Destination $destSrcPath

    # Update Visual Studio project files
    Write-Host "Updating FirstGen Visual Studio project files..." -ForegroundColor Cyan
    $firstGenProject = Join-Path $CYMDIST_FILES "FirstGen\CYMDistGIS_FirstGen.vcxproj"
    $firstGenInc = Join-Path $CYMDIST_FILES "FirstGen\inc"
    $firstGenSrc = Join-Path $CYMDIST_FILES "FirstGen\src"
    Invoke-VcxprojUpdate -ProjectPath $firstGenProject -IncludeDir $firstGenInc -SourceDir $firstGenSrc

    Write-Host "Updating SecondGen Visual Studio project files..." -ForegroundColor Cyan
    $secondGenProject = Join-Path $CYMDIST_FILES "SecGen\CYMDistGIS_SecGen.vcxproj"
    $secondGenInc = Join-Path $CYMDIST_FILES "SecGen\inc"
    $secondGenSrc = Join-Path $CYMDIST_FILES "SecGen\src"
    Invoke-VcxprojUpdate -ProjectPath $secondGenProject -IncludeDir $secondGenInc -SourceDir $secondGenSrc
   
   $global:LASTEXITCODE = 0

   return $outputArtifactsFolder
}