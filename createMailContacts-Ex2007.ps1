# Edit path to userList.csv
Import-CSV 'C:\userList.csv' |
foreach {
$domain = '@dexlab.net' # Edit variable to match your environment
$domainAlias = '@galias.dexlab.net' # Edit variable to match your environment
$OU = 'dexlab.net/Special Delivery' # Edit variable to match your environment
$userprincipalname = $_.Firstname + '.' +  $_.Lastname + $domain
$ExternalEmailAddress = $_.Firstname + “.” +  $_.Lastname + $domainAlias
$name = $_.Firstname + ' ' +  $_.Lastname + ' (SD)'
New-MailContact -ExternalEmailAddress $ExternalEmailAddress -Name $name -Alias $_.alias -OrganizationalUnit $OU -FirstName $_.Firstname -LastName $_.Lastname
}
