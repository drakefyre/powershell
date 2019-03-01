function Receive-Output
{
    process { Write-Host $_ -ForegroundColor Yellow }
}

#you were writing the ability to search by a specific KB, check after the $Search variable

Write-Output "This script searches for installed Windows Updates, and exports them to a file in C:\Temp\<SystemName>.csv." | Receive-Output
$Search = Read-Host -Prompt 'Input remote PC name.'
$KB = Read-Host -Prompt 'Input KB for Search'
Get-Hotfix -computername $search | Select HotfixID, Description, InstalledOn | Sort-Object InstalledOn
