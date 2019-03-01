#currently looks for list in C:\TEMP\pilot.txt

$computers = Get-Content C:\TEMP\pilot.txt
$Results = ForEach($Computer in $Computers) {Get-ADComputer $Computer | Select @{Name="OU";Expression={$_.DistinguishedName -replace "CN=$($Computer),",""}}, @{Name="ComputerName";Expression={$Computer}}
}
$Results