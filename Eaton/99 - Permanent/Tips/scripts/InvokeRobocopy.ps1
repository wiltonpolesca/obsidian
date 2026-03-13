function Invoke-Robocopy
{
   param(
      [Parameter(Mandatory = $true)]
      [string]$Source,

      [Parameter(Mandatory = $true)]
      [string]$Destination
   )

   robocopy $Source $Destination /E /NFL /NDL /NJH /NJS
   $robocopyExitCode = $LASTEXITCODE

   if ($robocopyExitCode -ge 8) {
      throw "Robocopy failed. Source: '$Source'. Destination: '$Destination'. Exit code: $robocopyExitCode"
   }

    # Robocopy uses non-zero exit codes (1-7) for successful outcomes.
    # Reset LASTEXITCODE so the workflow step does not fail incorrectly.
    $global:LASTEXITCODE = 0
}
