﻿<#
.SYNOPSIS
    Deletes computer from SCCM and AD
.DESCRIPTION
    Queries AD & SCCM, deletes the computer account from AD, and removes the computer object from SCCM 
.NOTES
   
.LINK 
   
.PARAMETER computerName
	Name of computer to delete from AD/SCCM
.PARAMETER sccmServer
	Name of the SCCM server to use
.PARAMETER sccmSite
	Name of the SCCM site to use
.EXAMPLE
	.\delcomp-adsccm2016.ps1 -computerName CON-01337
	.\delcomp-adsccm2016.ps1 -computerName CON-01337 -sccmServer sccm.contoso.com
	.\delcomp-adsccm2016.ps1 -computerName CON-01337 -sccmServer sccm.contoso.comm -sccmSite YOURSITE
#> 

param (
	[parameter(Mandatory=$true, HelpMessage="Enter a computer name")][string]$computerName,
	[parameter(Mandatory=$false, HelpMessage="Enter SCCM server")][string]$sccmServer='SERVER NAME GOES HERE',
	[parameter(Mandatory=$false, HelpMessage="Enter SCCM server")][string]$sccmSite='SITE NAME GOES HERE'
)

# find and delete the computer from AD
$dom = [System.DirectoryServices.ActiveDirectory.Domain]::GetCurrentDomain()
$root = $dom.GetDirectoryEntry()
$search = [System.DirectoryServices.DirectorySearcher]$root
$search.filter = "(&(objectclass=computer)(name=$computerName))"
$search.findall() | %{$_.GetDirectoryEntry() } | %{$_.DeleteObject(0)}

# find and delete from SCCM
$comp = get-wmiobject -query "select * from SMS_R_SYSTEM WHERE Name='$computerName'" -computername $sccmServer -namespace "ROOT\SMS\site_$sccmSite"
$comp.delete()


# output results
Write-Host "Deleted $computerName from AD. Removed $computerName from SCCM server $sccmServer, site $sccmSite"
