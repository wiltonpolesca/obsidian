. "$PSScriptRoot/scripts/TestHasGitChangedFilesByExt.ps1"
. "$PSScriptRoot/scripts/InvokeCymdistArtifactsCreation.ps1"
. "$PSScriptRoot/scripts/SetRcBuildVersion.ps1"
. "$PSScriptRoot/scripts/GetYesNo.ps1"

# Generate new artifacts based on the new config file and update the plugin project

$srcFolder = Join-Path $PSScriptRoot ".."
$diFmeTestServerFolder = "\\vm-PluginFME.cyme.local\Tests";
$outputArtifactsFolder = Invoke-CymdistArtifactsCreation -SrcFolder $srcFolder | Select-Object -Last 1

Write-Host "Checking if cymdist plugin has any changes..." -ForegroundColor Yellow
$hasChanges = Test-HasGitChangedFilesByExt `
  -LocalRepoPath (Join-Path $srcFolder "..\..") `
  -RemoteGitFolder 'FME Plugins\src\GATEWAY' `
  -Extensions @('cpp', 'h')

if (!$hasChanges) {
  Write-Host "No changes detected in generated files. No need to update version or run CI tests." -ForegroundColor Green
  exit 0
}

Write-Host "Updating FirstGen cymdist plugin version." -ForegroundColor Yellow
Set-RcBuildVersion `
  -RepoFilePath "FME Plugins/src/GATEWAY/CYMDISTGIS/FirstGen/CYMDistGISVer.rc" `
  -LocalFile "$srcFolder\GATEWAY\CYMDISTGIS\FirstGen\CYMDistGISVer.rc"  

Write-Host "Updating SecondGen cymdist plugin version." -ForegroundColor Yellow
Set-RcBuildVersion `
  -RepoFilePath "FME Plugins/src/GATEWAY/CYMDISTGIS/SecGen/CYMDistGISVer.rc" `
  -LocalFile "$srcFolder\GATEWAY\CYMDISTGIS\SecGen\CYMDistGISVer.rc"  

# Ask if user wants to run the integration test (default: No)
$runIntegration = Get-YesNo -Prompt 'Do you want to run the integration test?' -Default 'N'

if ($runIntegration -eq 'N') {
  Write-Host "Integration tests will be skipped." -ForegroundColor Green
  exit 0
}

$feature = $null

# If yes, ask if they want to test all features (default: Yes)
$testAllFeatures = Get-YesNo -Prompt 'Do you want to test ALL features?' -Default 'Y'

if ($testAllFeatures -eq 'N') {
  # If not all, ask which specific feature
  while ($true) {
    $feature = Read-Host 'Enter the feature you want to test'
    if (-not [string]::IsNullOrWhiteSpace($feature)) { break }
    Write-Host 'Feature name cannot be empty. Please enter a value.' -ForegroundColor Yellow
  }
}

Write-Host 'Building the plugin ...' -ForegroundColor Yellow

Write-Host 'Preparing environment to run integration tests...' -ForegroundColor Yellow

$dinamicFolder = (Get-Date).ToString("yyyyMMddHHmmss")
$testFolder = Join-Path $diFmeTestServerFolder $dinamicFolder
New-Item -ItemType Directory -Path "$testFolder" -Force

Write-Host "Artifacts folder: $outputArtifactsFolder" -ForegroundColor Gray

Write-Host 'Copying files...' -ForegroundColor Yellow

New-Item -ItemType Directory -Path "$testFolder/Plugins" -Force
New-Item -ItemType Directory -Path "$testFolder/Schema" -Force

$pluginsFolder = Join-Path $srcFolder "Released plugins"
Invoke-Robocopy -Source "$pluginsFolder\FirstGen" -Destination "$testFolder\Plugins\FirstGen"
Invoke-Robocopy -Source "$pluginsFolder\SecGen" -Destination "$testFolder\Plugins\SecGen"
Invoke-Robocopy -Source "$outputArtifactsFolder\json_files" -Destination "$testFolder\Sources"
Invoke-Robocopy -Source "$srcFolder\FMEPluginsTools\FMEPluginsTester\Tests\CymdistGIS\Scripts" -Destination "$testFolder\Scripts"
Copy-Item -Path "$outputArtifactsFolder\cymdist.sch" -Destination "$testFolder\Schema\cymdist.sch"
Copy-Item -Path "$PSScriptRoot\CYMENetworkWriter.config" -Destination "$testFolder\CYMENetworkWriter.config"

Write-Host 'Running tests ...' -ForegroundColor Yellow
$remoteTestProject = Join-Path $srcFolder "..\test\FMEPluginsTools\FMERemotePluginTests\FMERemotePluginTests.csproj" 

if ($testAllFeatures -eq 'N') {
  dotnet run --project $remoteTestProject "c:\Tests\$dinamicFolder" --feature $feature
} else {
  dotnet run --project $remoteTestProject "c:\Tests\$dinamicFolder"
}

Write-Host "Deleting test files ..." -ForegroundColor Cyan
if (Test-Path "$testFolder") {
    Remove-Item "$testFolder" -Recurse -Force
}

Write-Host "Done." -ForegroundColor Gray
