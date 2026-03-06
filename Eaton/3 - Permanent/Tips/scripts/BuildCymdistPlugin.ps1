function Invoke-BuildCymdistPlugin {
   param(
      [Parameter(Mandatory = $true)]
      [string]$solutionPath,

      [Parameter(Mandatory = $true)]
      [string]$configuration,

      [ValidateSet('Win32', 'x64')]
      [Parameter(Mandatory = $true)]
      [string]$platform
   )

   $vswherePath = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

   if (-not (Test-Path $vswherePath)) {
      Write-Error "vswhere.exe is missing! Cannot proceed with discovery."
      exit 1
   }

   $MSBUILD = & $vswherePath -latest -products * -requires Microsoft.Component.MSBuild -find "MSBuild\**\Bin\MSBuild.exe" | Select-Object -First 1

   if (-not $MSBUILD) {
      Write-Error "MSBuild.exe not found. Please ensure Visual Studio with MSBuild is installed."
      exit 1
   }

   Write-Host "Building $solutionPath with configuration $configuration and platform $platform..." -ForegroundColor Yellow
   & "$MSBUILD" "$solutionPath" /t:Clean /p:Configuration=$configuration /p:Platform=$platform /m /clp:Summary /v:m
   & "$MSBUILD" "$solutionPath" /t:Build /p:Configuration=$configuration /p:Platform=$platform /m /clp:Summary /v:m
   Write-Host "Finished building $solutionPath with configuration $configuration and platform $platform." -ForegroundColor Green
}
