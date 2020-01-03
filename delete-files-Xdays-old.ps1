# Delete all files (and only files) older than X day(s)

# Directory
$Path = "MODIFY DIRECTORY"

# X Days
$Daysback = "-X"

$CurrentDate = Get-Date
$DatetoDelete = $CurrentDate.AddDays($Daysback)

Get-ChildItem $Path -Recurse -File | Where-Object { $_.LastWriteTime -lt $DatetoDelete } | Remove-Item
