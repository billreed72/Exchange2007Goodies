$Password=Read-Host "Enter Password" -AsSecureString
Import-CSV C:\userList.csv |
foreach {
$userprincipalname = $_.Firstname + ì.î +  $_.Lastname + ì@dexlab.netî
$firstandlastname = $_.Firstname + ì î +  $_.Lastname
new-mailbox -name $firstandlastname -alias $_.alias -FirstName $_.Firstname -LastName $_.Lastname -userPrincipalName  $userprincipalname -database "First Storage Group\Mailbox Database" -OrganizationalUnit Users -Password $Password
}
