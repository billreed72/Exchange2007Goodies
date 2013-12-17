Import-CSV C:\pfDatabases.csv |
foreach {
$storageGroup = $_.storageGroup
$pfDBName = $_.pfDBName
New-PublicFolderDatabase -Name $pfDBName -StorageGroup $storageGroup
}
