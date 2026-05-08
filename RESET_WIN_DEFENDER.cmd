<# : batch script
@echo off
powershell -nop "if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) { Start-Process -Verb RunAs 'cmd.exe' -ArgumentList '/c \"%~dpnx0\" %*' } else { Invoke-Expression ([System.IO.File]::ReadAllText('%~f0')) }"
goto :eof
#>

Write-Host "`nWindows 11 Tool for CLEAR Windows Defender - history of detected Threads, CFA history, items in Quarantine"
Write-Host "`nPress any key to run operation..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")

$ClearAV = $true
$ClearQuarantine = $true
$ClearCFA = $true

$Defender = 'C:\ProgramData\Microsoft\Windows Defender'
$Quarantine = "$Defender\Quarantine"
$Scans = "$Defender\Scans"
$Service = "$Scans\History\Service"
$DB = "$Scans\mpenginedb.db*"

if ($ClearAV)         { $C1 = "rd /s /q `"$Service`" & " }
if ($ClearQuarantine) { $C2 = "rd /s /q `"$Quarantine`" & " }
if ($ClearCFA)        { $C3 = "del /f `"$DB`" & " }

$choice1 = (Read-Host "`nA restart is required to clear the Protection history. Enter y to restart now").ToLower()
if ($choice1 -eq "y") { Restart-Computer }