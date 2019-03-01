<# ASSUMPTIONS MADE
   
I'm assuming you've already logged into the target PC and are running this script from there.

References:
https://morgansimonsen.com/2009/01/29/backing-up-your-windows-vista7-profile-using-robocopy/

#Prompt for new PC name
#$NewPC =  Read-Host -Prompt 'Input new PC name'
# Original code -
#robocopy.exe $env:USERPROFILE \\$NewPC\$env:username /E /ZB /R:0 /W:0 /XJ /NFL /XD Music OneDrive “Temporary Internet Files” OfficeFileCache Temp *cache* Spotify WER AppData /XF *cache* *.ost *.dat

/#>


Write-Host "This script copies data from the old PC, to the specified user on this PC."
Write-Host "======================================================================================="

#Variables

	#Directory List, add additional directories you want to copy here
	$dirs = @("Contacts","Desktop","Documents","Downloads","Favorites","Links","Pictures","Videos")

	#Prompt for old PC name
	$Computer = Read-Host -Prompt 'Enter the computer to copy from'

	#Prompt for username
	$User = Read-Host -Prompt 'Enter the user profile to copy'

#robocopy specified C:\users\[USERNAME] directory, Music excluded.

#test if C:\dinsmore\migration exists, if not make it

$migrationfolder = "C:\dinsmore\migration"
    if ( -Not (Test-Path $migrationfolder.Trim() ))
    {
    New-Item -Path $migrationfolder -ItemType Directory
    }
    
#copy and rename the wallpaper file to something intelligible,drop it in C:\dinsmore\migration\wallpaper.jpg
     Copy-Item "\\$Computer\C$\Users\$User\AppData\Roaming\Microsoft\Windows\Themes\TranscodedWallpaper*" -Destination "C:\dinsmore\migration\wallpaper.jpg"

#loop through the $dirs array and run robocopy on it.
ForEach ($dir in $dirs) {
    robocopy.exe \\$Computer\C$\users\$User\$dir C:\Users\$User\$dir /E /ZB /R:0 /W:0 /XJ /NFL /XF *cache* *.ost *.dat
    }
   
   