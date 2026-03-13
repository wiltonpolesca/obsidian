
function Get-YesNo {
    param(
        [Parameter(Mandatory)]
        [string]$Prompt,

        [ValidateSet('Y','N')]
        [string]$Default  # 'Y' or 'N'
    )

    # Build prompt text with default hint
    $defaultHint = if ($Default -eq 'Y') { '[Y/n]' } else { '[y/N]' }

    while ($true) {
        $answer = Read-Host "$Prompt $defaultHint"
        $answer = $answer.Trim()

        if ([string]::IsNullOrWhiteSpace($answer)) {
            return $Default  # use default on empty input
        }

        switch -Regex ($answer) {
            '^(y|yes)$' { return 'Y' }
            '^(n|no)$'  { return 'N' }
            default     { Write-Host "Please answer 'y' or 'n' (or press Enter for default: $Default)." -ForegroundColor Yellow }
        }
    }
}
