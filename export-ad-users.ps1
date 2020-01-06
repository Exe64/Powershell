#Export users list from AD OU in a .csv file

#Variables 
$ou = "OU=WHATE,OU=YOU,OU=WANT,DC=TO,DC=EXPORT"
$path = c:\PATH\TO\FILE.csv

Get-ADUser -filter { enabled -eq $True } -SearchBase $ou –properties sn,Givenname,Samaccountname,mail,telephoneNumber,mobile,department | select-object sn,Givenname,Samaccountname,mail,telephoneNumber,mobile,department | export-csv –path $path –delimiter ";"
