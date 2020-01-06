#THIS SCRIPT IS BUILD TO :
#- CREATE A FOLDER FOR EACH USER IN create-folder-users-db.csv
#- SETUP PERMISSION ON EACH FOLDER WITH FullControl / NTFSOwner

#Install-Module NTFSSecurity	

#VARIABLES

  $Server = "PATH\TO\PARENT\FOLDER"
  $Users = import-csv -path "PATH\TO\create-folder-users-db.csv"
  $Domain = "mairie.local"
	
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
