function Receive-Output
{
    process { Write-Host $_ -ForegroundColor Yellow }
}

Write-Output "This script searches for installed software, and outputs the uninstall string." | Receive-Output
$Search = Read-Host -Prompt 'Input search term (e.g., Microsoft, Adobe, Google, etc)'
$Output = (Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object {$_.DisplayName -match "$Search" } | Select-Object -Property DisplayName, UninstallString)
if ($Output.Length -eq 0) {
    write-host "Search returned no results."}
else {
Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object {$_.DisplayName -match "$Search" } | Select-Object -Property DisplayName, UninstallString
}