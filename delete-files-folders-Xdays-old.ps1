# Delete all files and folders older than X day(s)

# Directory
$Path = "MODIFY DIRECTORY"

# X Days
$Daysback = "-X"

$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)

Get-ChildItem $Path -Recurse | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
