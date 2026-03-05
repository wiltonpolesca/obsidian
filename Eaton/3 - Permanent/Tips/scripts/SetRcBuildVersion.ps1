function Set-RcBuildVersion {
    [CmdletBinding(SupportsShouldProcess = $true)]
    param(
        # Path inside repo to the version file
        [Parameter(Mandatory = $true)]
        [string] $RepoFilePath,

        # Local file you want to update
        [Parameter(Mandatory = $true)]
        [ValidateScript({ Test-Path -LiteralPath $_ })]
        [string] $LocalFile,

        # Show actions without changing anything
        [switch] $DryRun
    )

    # Ensure git exists
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git is not installed or not available in the PATH."
    }

    # Fetch latest
    Write-Host "Fetching latest origin..." -ForegroundColor Cyan
    git fetch origin | Out-Null

    # Extract file content from origin/main
    Write-Host "Reading file from origin/main..." -ForegroundColor Cyan
    # $originTmp = Join-Path $env:TEMP ([System.IO.Path]::GetRandomFileName())
    $originTmp = "./" + ([System.IO.Path]::GetRandomFileName())

    # Use blob-syntax (origin/main:path) so git returns the file contents
    (git --no-pager show "origin/main:$RepoFilePath") |
    Set-Content -Path $originTmp -Encoding UTF8

    # Regex for version extraction
    $pattern = '#define\s+VER_PRODUCTVERSION_STR\s+"(\d+)(\s*,\s*)(\d+)(\s*,\s*)(\d+)(\s*,\s*)(\d+)(\\0)("\s*)'

    # Read origin version
    $originContent = Get-Content -Raw -LiteralPath $originTmp
    if ($originContent -notmatch $pattern) {
        throw "Version not found in origin file: $RepoFilePath"
    }

    $oMajor = [int]$Matches[1]
    $oMinor = [int]$Matches[3]
    $oBuild = [int]$Matches[5]
    $oRev = [int]$Matches[7]

    $newBuild = $oBuild + 1
    $newVersion = "$oMajor, $oMinor, $newBuild, $oRev"

    Write-Host "Origin version:     $oMajor, $oMinor, $oBuild, $oRev"
    Write-Host "New version:        $newVersion" -ForegroundColor Yellow

    # Read local file
    $localContent = Get-Content -Raw -LiteralPath $LocalFile
    if ($localContent -notmatch $pattern) {
        throw "Local file does not contain VER_PRODUCTVERSION_STR: $LocalFile"
    }

    # Replace version in local file while preserving formatting
    $updated = [regex]::Replace($localContent, $pattern, {
            param($m)

            $sep1 = $m.Groups[2].Value
            $sep2 = $m.Groups[4].Value
            $sep3 = $m.Groups[6].Value
            $nul = $m.Groups[8].Value
            $trail = $m.Groups[9].Value

            "#define VER_PRODUCTVERSION_STR`t`t`t""$oMajor$sep1$oMinor$sep2$newBuild$sep3$oRev$nul$trail"
        }, 1)

    if ($DryRun) {
        Write-Host "[DryRun] Local file WOULD be updated to version: $newVersion" -ForegroundColor Green
        return
    }

    # Write final file
    if ($PSCmdlet.ShouldProcess($LocalFile, "Update version to $newVersion")) {
        Set-Content -LiteralPath $LocalFile -Value $updated -Encoding UTF8 -NoNewLine
        Write-Host "Updated local file → version now: $newVersion" -ForegroundColor Green
    }

    # Cleanup
    Remove-Item $originTmp -Force -ErrorAction SilentlyContinue
}