#THIS SCRIPT IS BUILD TO :
#- CREATE A FOLDER FOR EACH USER IN create-folder-users-db.csv
#- SETUP PERMISSION ON EACH FOLDER WITH FullControl / NTFSOwner

#IF NTFSSECURITY MODULE IS NOT INSTALLED ON YOUR SYSTEM
#Install-Module NTFSSecurity	

#VARIABLES

$Server = "C:\PATH\TO\PARENT\FOLDER"
$Users = ("user1","user2","user3")
$Domain = "DOMAIN"
	
#SCRIPT

foreach($User in $Users)
{
#FOLDER CREATION
New-Item "$Server\$User" -ItemType Directory

#NTFS PERMISSIONS
Add-NTFSAccess -Path "$Server\$User" -Account "$User@$Domain" -AccessRights FullControl

#FOLDER OWNER
Set-NTFSOwner -Path "$Server\$User" -Account "$User@$Domain"
}
