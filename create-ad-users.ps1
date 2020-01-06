#THIS SCRIPT IS BUILT TO :
#- CREATE USERS FROM A FILE (SEE create-ad-users-db.csv) IN A SPECIFIC OU
#- ADD USERS ON SPECIFIC GROUPS
#- CREATE A SCAN (OR PERSONNAL) FOLDER FOR EACH USER

#VARIABLES TO MODIFY

  $users = import-csv -path "PATH\TO\create-ad-users-db.csv" -delimiter ";"
  $scan = "PATH\TO\SCAN\FOLDER"
  $domain = "DOMAIN"
  $group1 = "GROUP1"
  $group2 = "GROUP2"
  $group3 = "GROUP3"
  $group4 = "GROUP4"
  $ou= "OU=WHERE,OU=YOU,OU=WANT,DC=TO,DC=CREATE"
    
#USER CREATION 
foreach($user in $users)
  {
  $lastname= $user.lastname
  $firstname= $user.firstname
  $login= $user.login
 	$pass= $user.pass
  $name = $firstname + " " + $lastname
    
  #AD ACCOUNT CREATION
  New-ADuser -name $name -surname $lastname -givenname $firstname -SamAccountName $login -UserPrincipalName $login@$domain -DisplayName $name -Path $ou -AccountPassword (ConvertTo-SecureString $pass -AsPlainText -Force) -Enabled $true
    
  #ADD USER TO SPECIFIC GROUPS
  Add-ADGroupMember -Identity $group1 -Members $login
  Add-ADGroupMember -Identity $group2 -Members $login
  Add-ADGroupMember -Identity $group3 -Members $login
  Add-ADGroupMember -Identity $group4 -Members $login

  #CREATE A SCAN FOLDER FOR THE USER
	New-Item "$scan\$login" -ItemType Directory
	
	#ADD NTFS SECURITY ON THE SCAN FOLDER
	Add-NTFSAccess -Path "$scan\$login" -Account "$login@$domain" -AccessRights FullControl
	
	#MODIFY SCAN FOLDER OWNER
	Set-NTFSOwner -Path "$scan\$login" -Account "$login@$domain"
  }
