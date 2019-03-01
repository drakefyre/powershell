#checks the status of logged on users remotely

$array = @("18T4GB2")
$array

foreach ($computer in $array)
{
Get-WmiObject –ComputerName $computer –Class Win32_ComputerSystem | Select-Object UserName
}
