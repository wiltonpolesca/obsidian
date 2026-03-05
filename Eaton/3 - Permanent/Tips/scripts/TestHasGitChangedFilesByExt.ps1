. "$PSScriptRoot/GetGitChangedFilesByExt.ps1"

function Test-HasGitChangedFilesByExt {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory=$true)]
        [string] $LocalRepoPath,

        [Parameter(Mandatory=$true)]
        [string] $RemoteGitFolder,

        [Parameter(Mandatory=$true)]
        [string[]] $Extensions,

        [Parameter(Mandatory=$false)]
        [string] $BaseRef = 'origin/main'
    )

    $files = Get-GitChangedFilesByExt -LocalRepoPath $LocalRepoPath -RemoteGitFolder $RemoteGitFolder -Extensions $Extensions -BaseRef $BaseRef
    
    # Returns true if there are any changed files with the specified extensions, false otherwise.
    return ($files.Count -gt 0)
}