# ---------------------------------------------------------------------------
# Get-LogDir:  Return the location for logs and output files
# ---------------------------------------------------------------------------

function Get-LogDir
{
  try
  {
    $ts = New-Object -ComObject Microsoft.SMS.TSEnvironment -ErrorAction Stop
    if ($ts.Value("LogPath") -ne "")
    {
      $logDir = $ts.Value("LogPath")
    }
    else
    {
      $logDir = $ts.Value("_SMSTSLogPath")
    }
  }
  catch
  {
    $logDir = $env:TEMP
  }
  return $logDir
}

Function Get-BCDObject()
{
	$bcdEntries = bcdedit /enum firmware | Where { $_ -ne "" }
	$bcdObject = @()
	
	$Firmware = $False
	
	foreach ($bcdEntry in $bcdEntries)
	{
		If ($bcdEntry -eq "Firmware Boot Manager")
		{
			$Firmware = $true
		}
		Elseif ($bcdEntry -eq "Windows Boot Loader" -or $bcdEntry -eq "Windows Boot Manager" -or ($bcdEntry -eq "") -or $bcdEntry.Contains("-----"))
		{
			If (!($bcdEntry.Contains("-----")))
			{
				$Firmware = $false
			}
			Else
			{
				If ($Firmware -eq $true)
				{
					Write-Information ''
					Write-Information "Skipping PSobject creation because '$bcdEntry' is part of 'Firmware Boot Manager'"
				}
				Else
				{
					Write-Information ''
					Write-Information "'$bcdEntry' encountered, creating PSobject"
					$object1 = New-Object PSObject
					$bcdObject += $object1
				}
			}
		}
		Else
		{
			If ($Firmware -eq $false)
			{
				$bcdsplit = $bcdEntry.Split(" ")
				$property = $bcdsplit[0]
				$value = ($bcdEntry.Substring($bcdsplit[0].length)).trim()
				
				#If ($property -ne '' -or $property -ne ' ' -or $property -ne $null)
				If ($property -ne '')
				{
					If (!($object1))
					{
						Write-Information "PSObject does not exist, skipping '$property'."
					}
					Else
					{
						Write-Information "Adding '$property' to list"
						$object1 | Add-Member -MemberType NoteProperty -Name $($property) -Value $value
					}
				}
			}
		}
	}
	return $bcdObject
}

$logDir = Get-LogDir
Start-Transcript "$logDir\Remove-OldBCDEntries.log"

$bcdEntriesBefore = bcdedit /enum firmware
Write-Information 'BCDEdit before:'
ForEach ($bcdEntryBefore in $bcdEntriesBefore)
{
 Write-Information "$($bcdEntryBefore)"
}
Write-Information 'End BCDEdit before'
Write-Information ''

If (Test-Path -Path "HKLM:\SYSTEM\ControlSet001\Control\MiniNT" -PathType Container)
{
	Write-Information "Running in WinPE."
	Write-Information ''
	$script:Offline = $true
}
Else
{
	Write-Information "Running in Full OS."
	Write-Information ''
	$script:Offline = $false
}

# Store bcdedit output in a Powershell object
$bcdObjs = Get-BCDObject

foreach ($bcdObj in $bcdObjs)
{
	If ((get-culture).name -eq 'fr-FR')
	{
		$BootIdentifier = $bcdObj.identificateur
	}
	Else
	{
		$BootIdentifier = $bcdObj.identifier
	}

	$BootDescription = $bcdObj.description
    If ($script:Offline)
	{
  	If ($BootDescription -eq "Windows Boot Loader" -or $BootDescription -eq "Windows Boot Manager")
		{
		Write-Information "Deleting '$BootIdentifier'"
		bcdedit /delete "$BootIdentifier" /cleanup /f
		}
	Else
		{
		Write-Information "Skipping '$BootIdentifier'"
		}
	}
    Else
	{
    If ($BootDescription -eq "Windows Boot Loader" -or $BootDescription -eq "Windows Boot Manager" -and $BootIdentifier -ne "{bootmgr}")
		{
		Write-Information "Deleting '$BootIdentifier'"
		bcdedit /delete "$BootIdentifier" /cleanup /f
		}
	Else
		{
		Write-Information "Skipping '$BootIdentifier'"
		}
	}
}
$bcdEntriesAfter = bcdedit /enum firmware
Write-Information 'BCDEdit after:'
ForEach ($bcdEntryAfter in $bcdEntriesAfter)
{
 Write-Information "$($bcdEntryAfter)"
}

Stop-Transcript