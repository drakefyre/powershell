<#
function Receive-Output
{
    process { Write-Host $_ -ForegroundColor Yellow }
}

Write-Output "This script searches for installed software, and outputs the uninstall string." | Receive-Output
/#>
Import-Module -Name \\cinutl01\sources$\PostImage\Win10\Scripts\Get-RemoteProgram.ps1
    
    #below string allows you to search a remote system
    #$Search = Read-Host -Prompt 'Input old PC name'

    #Switches:
    #Get-RemoteProgram [[-ComputerName] <String[]>] [[-Property] <String[]>] [-IncludeProgram <String[]>] [-ExcludeProgram <String[]>] 
    #[-ProgramRegExMatch] [-LastAccessTime] [-ExcludeSimilar] [-SimilarWord <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]

#test if C:\dinsmore\migration exists, if not make it

$migrationfolder = "C:\dinsmore\migration"
    if ( -Not (Test-Path $migrationfolder.Trim() ))
    {
    New-Item -Path $migrationfolder -ItemType Directory
    }



Get-RemoteProgram -ComputerName $env:COMPUTERNAME -ExcludeProgram *Update*,"*service pack*",*Intel*,"*SQL*","*Visual Studio*","*.Net*",*driver*,"*VC++*","*C++*",*runtime*,"*Run Time*",*SilverLight*,"Local Administrator Password Solution",*MSXML*,*Chrome*,*MeadCo*,*docuPrinter*,"Adobe Reader*",*Cisco*,*Sophos*,*iManage*,"Configuration Manager Client",*dell*,Bighand*,BEC*,Kaspersky*,"Proxy Pro*",Realtek* | Sort ProgramName | Out-File C:\dinsmore\migration\InstalledPrgs.csv

#place output in C:\dinsmore\migration