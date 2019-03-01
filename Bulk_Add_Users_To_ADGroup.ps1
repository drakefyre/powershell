<#
.SYNOPSIS
Bulk Add users in a text file to a group

.DESCRIPTION
Script checks AD to see if a user is a member of the defined AD group.
If the user is not, then they are added

.PARAMETER 
None
 

.EXAMPLE
Ran as stand alone script.  

.NOTES
Created: 8/27/2015
Authored by: David Dubuque
#>

###Bulk Add Users to a group ###

###Variables###
$UserList = Get-Content "C:\Users\username\Desktop\Example.txt"
$GroupName = "Example.Groupname"
$Members = Get-ADGroupMember -Identity $GroupName -Recursive | Select -ExpandProperty SAMAccountName

###Simple for each to see if each user is in the desired group already.  If they are not, then they are added.###

ForEach ($user in $UserList)
 {
    
    If ($Members -contains $user) 
            {
                Write-Host "$user is member of $GroupName"
            } 
    
    Else    
            {
                Write-Host "$user is not a member. Attempting to add now, run script again for verification"
                Add-ADGroupMember -Identity $GroupName -Members $User
            }
 }