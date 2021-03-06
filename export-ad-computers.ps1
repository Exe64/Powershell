#SCRIPT TO EXPORT COMPUTER LIST FROM AN OU WITH NAME / OS / LAST LOGON DATE

#VARIABLES

$ou = "OU=WHATE,OU=YOU,OU=WANT,DC=TO,DC=EXPORT"
$path = c:\PATH\TO\ADcomputerslist.csv

#SCRIPT
Get-ADComputer -Filter { enabled -eq $True } -SearchBase $ou –properties Name,OperatingSystem,OperatingSystemVersion,LastLogonDate | Select-Object Name,OperatingSystem,OperatingSystemVersion,LastLogonDate | Export-CSV -path $path -NoTypeInformation -Encoding UTF8
