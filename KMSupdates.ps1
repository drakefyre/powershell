#http://get-cmd.com/?p=4452

$ADComputers = Get-ADComputer -Filter 'ObjectClass -eq "Computer"' -SearchBase "OU=Servers,DC=GET-CMD,DC=local" | Select -Expand DNSHostName
 
foreach ($Comp in $ADComputers) {
 
slmgr.vbs $Comp -SKMS <FQDN_KMS_Server.get-cmd.local>
slmgr.vbs -ato
 
}