function Receive-Output
{
    process { Write-Host $_ -ForegroundColor Yellow }
}


Write-Output "This script searches for installed Windows Updates, and exports them to a file in C:\Temp\<SystemName>.csv." | Receive-Output
$Search = Read-Host -Prompt 'Input remote PC name.'
Get-Hotfix -computername $search | Select HotfixID, Description, InstalledOn | Sort-Object InstalledOn
