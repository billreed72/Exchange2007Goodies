Import-CSV C:\pfNames.csv |
foreach {
$pfName = $_.pfName
$exServer = $_.exServer
New-PublicFolder -Name $_.pfName -Path '\' -Server $_.exServer
}
