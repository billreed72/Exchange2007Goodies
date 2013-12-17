Import-CSV C:\pfDatabases.csv |
foreach {
$pfDBName = $_.pfDBName
Mount-Database -Identity $pfDBName
}
