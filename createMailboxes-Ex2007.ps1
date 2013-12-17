$Password=Read-Host "Enter Password" -AsSecureString
Import-CSV C:\userList.csv |
foreach {
$userprincipalname = $_.Firstname + '.' +  $_.Lastname + '@dexlab.net'
$firstandlastname = $_.Firstname + ' ' +  $_.Lastname
new-mailbox -name $firstandlastname -alias $_.alias -FirstName $_.Firstname -LastName $_.Lastname -userPrincipalName  $userprincipalname -database "First Storage Group\Mailbox Database" -OrganizationalUnit Users -Password $Password
}
