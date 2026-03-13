# "scripts/GetGitChangedFilesByExt.ps1"

function Get-GitChangedFilesByExt {
    [CmdletBinding()]
    param(
        # Path to the local git folder (defaults to current folder)
        [Parameter(Mandatory=$false)]
        [string] $LocalRepoPath = (Get-Location).Path,

        # Repo-relative folder to scan (e.g., 'FME Plugins/src/GATEWAY')
        [Parameter(Mandatory=$true)]
        [string] $RemoteGitFolder,

        # Extensions to match (with or without dot). Example: @('cpp','h')
        [Parameter(Mandatory=$true)]
        [string[]] $Extensions,

        # Base reference to compare against (default: origin/main)
        [Parameter(Mandatory=$false)]
        [string] $BaseRef = 'origin/main'
    )

    # Ensure git is available
    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        throw "Git is not installed or not on PATH."
    }

    # Validate repo
    $inside = & git -C $LocalRepoPath rev-parse --is-inside-work-tree 2>$null
    if ($LASTEXITCODE -ne 0) {
        throw "The path '$LocalRepoPath' is not a Git repository."
    }

    & git -C $LocalRepoPath fetch origin | Out-Null

    # Normalize folder path for Git pathspec (forward slashes, no leading .\)
    $folderSpec = $RemoteGitFolder -replace '\\','/'
    if (-not $folderSpec.EndsWith('/')) { $folderSpec += '/' }

    # Normalize extension set
    $extSet = $Extensions |
        ForEach-Object { $_.Trim().TrimStart('.').ToLowerInvariant() } |
        Where-Object { $_ -ne '' } |
        Sort-Object -Unique

    if ($extSet.Count -eq 0) {
        throw "No valid extensions provided."
    }

    # --- Collect changed files in MR (BaseRef...HEAD) ---
    $range = "$BaseRef...HEAD"
    $diffArgs = @(
        '-C', $LocalRepoPath,
        'diff', '--name-only',
        '--diff-filter=ACMRTD',  # A, C, M, R, T, D (add/delete/modify/rename/type)
        $range,
        '--', $folderSpec
    )
    $changedInMR = & git @diffArgs 2>$null

    # Include uncommitted working changes vs HEAD
    $workingChanged = @()
    $diffArgsWorking = @(
        '-C', $LocalRepoPath,
        'diff', '--name-only',
        '--diff-filter=ACMRTD',
        '--', $folderSpec
    )
    $workingChanged = & git @diffArgsWorking 2>$null

    # Combine and filter by extension
    $allChanged = @($changedInMR + $workingChanged) | Where-Object { $_ } | Sort-Object -Unique

    $matching = $allChanged | Where-Object {
        $ext = [System.IO.Path]::GetExtension($_).TrimStart('.').ToLowerInvariant()
        $extSet -contains $ext
    }

    return $matching
}