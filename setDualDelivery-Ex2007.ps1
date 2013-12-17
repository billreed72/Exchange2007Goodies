Import-CSV C:\userList.csv |
foreach {
$ExternalEmailAddress = $_.Firstname + “.” +  $_.Lastname + “@galias.dexlab.net”
Set-Mailbox $_.alias -DeliverToMailboxAndForward:$True -ForwardingAddress $ExternalEmailAddress
}
