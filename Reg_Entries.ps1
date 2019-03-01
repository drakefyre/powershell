<# 

Examples:

    New-ItemProperty -Path "HKCU:\dummy\NetwrixKey" -Name "NetwrixParam" -Value ”NetwrixValue”  -PropertyType "String"

    ####

    New-Item          -Path HKCU:\Software\Testing  -Name NewKey -Value "Default Value" -Force
    New-ItemProperty  -Path  HKCU:\Software\Testing\NewKey -Name "Foo" -PropertyType "String" -Value 'The answer is 42'

    ####


#>

New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\Client\Common\Options -Name EnableMCC -Type "String" -Value 'Y'

New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Common\Options -Name EnableMCC -Type "String" -Value 'Y'
New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Common\Options -Name "Show Explorer Nodes Mask" -Type "dword" -Value '00000000'

New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\FileSite\Commands\Folder\New -Name Commands -Type "String" -Value 'IManExt2.NewIManDocumentFolderCmd,IManExt2.NewIManDocumentSearchFolderCmd,-,IManExt.NewMessageCmd'
New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\FileSite\Commands\Folder\New -Name MenuText -Type "String" -Value 'New'

New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\FileSite\Commands\Workspace\New -Name Commands -Type "String" -Value 'IManage.FlexibleFolderCmd@Folder...,'
New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\FileSite\Commands\Workspace\New -Name MenuText -Type "String" -Value '476'

New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Integration\Options -Name EnhancedApplicationIntegrationOpen -Type "dword" -Value '00000001'
New-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Integration\Options -Name EnhancedApplicationIntegrationSave -Type "dword" -Value '00000001'

Remove-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Integration\Options -Name EnhancedApplicaitonIntegrationOpen
Remove-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Integration\Options -Name EnhancedApplicaitonIntegrationSave

Remove-ItemProperty -Path HKLM:SOFTWARE\Wow6432Node\Interwoven\Worksite\8.0\Client\Common\Options -Name EnableMCC



