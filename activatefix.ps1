$win7list =  get-content "M:\scripts\win7list.txt"

foreach ($computer in $win7list)
{
if (Test-Connection -Quiet $computer -BufferSize 16 -Count 1)
    {

    Write-Host "Connecting to $computer"
    Invoke-Command -ComputerName $computer -ScriptBlock {(wusa.exe /uninstall /KB:971033 /quiet /norestart),(stop-service sppsvc), 
    (Remove-Item "$env:windir\system32\7B296FB0-376B-497e-B012-9C450E1B7327-5P-0.C7483456-A289-439d-8115-601632D005A0" -Force),
    (Remove-Item "$env:windir\system32\7B296FB0-376B-497e-B012-9C450E1B7327-5P-1.C7483456-A289-439d-8115-601632D005A0" -Force), 
    (Remove-Item "$env:windir\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform\tokens.dat" -Force),
    (Remove-Item "$env:windir\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\SoftwareProtectionPlatform\cache\cache.dat" -Force),
    (Start-Service sppsvc), (slmgr //B /ipk FJ82H-XT6CR-J8D7P-XQJJ2-GPDD4),(slmgr //B /ato) }
    }
else{
    write-host "$computer is offline." -ForegroundColor Magenta
    }
}