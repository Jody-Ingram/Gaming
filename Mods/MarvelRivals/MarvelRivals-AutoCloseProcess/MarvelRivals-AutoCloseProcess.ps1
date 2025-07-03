<#
Script  :  MarvelRivals-AutoCloseProcess.ps1
Version :  1.1
Date    :  7/2/2025
Author  :  Jody Ingram
Notes   :  Monitors for Marvel Rivals game exit and silently ensures any lingering process is force-closed.
Pre-reqs: The batch file calls this script so that it runs silently in the background. Run "MarvelRivals-AutoCloseProcess-FirstRun.bat".
#>

# Define the process
$processName = "MarvelRivals"
$wasRunning = $false

while ($true) {
    $proc = Get-Process -Name $processName -ErrorAction SilentlyContinue
    if ($proc) {
        $wasRunning = $true
    } elseif ($wasRunning -and -not $proc) {
        Stop-Process -Name $processName -Force -ErrorAction SilentlyContinue
        $wasRunning = $false
    }

    Start-Sleep -Seconds 5
}
