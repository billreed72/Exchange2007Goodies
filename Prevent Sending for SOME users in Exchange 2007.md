Old Option:
===========
Turing the quota down with/without turning off local delivery check box... ick!
<b>Problem:</b> Can cause mail to fail delivery.

Newer/Better Option
===================
<b>Requirements:</b>
1) stop local delivery
2) stop user from sending
3) Allow users to access old Exchange mail but not send

<b>Step 1:</b> Create a new Distribution Group
 - Members will be restricted from sending emails
 - Must be a universal group
 
 <b>POWERSHELL</b>
new-DistributionGroup -Name ’NoSendingMailForYou’ -Type ‘Distribution’ -SamAccountName ’NoSendingMailForYou’ -Alias ‘NoSendingMailForYou’

<b>Step 2:</b> Create a new Transport Rule
 - Conditions:	From members of a distribution list
 		- Choose the new distribution group
 - Actions:	Send rejection message to sender with enhanced status code
		Message: 
			“Please login to your new Google Apps account.
			The URL is http://www.google.com
			You are no longer authorized to send email from this system.
			For support, contact our helpdesk at 714-555-1234”

<b>POWERSHELL</b>
New-TransportRule -Name ’PreventSending’ -Comments ‘’ -Priority ‘0’	-Enabled $true -FromMemberOf ‘NoSendingMailForYou@contoso.com’ -RejectMessageReasonText ‘Please login to your new Google Apps account. The URL is http://www.google.com. You are no longer authorized to send email from this system. For support, contact our helpdesk at 714-555-1234.’ -RejectMessageEnhancedStatusCode ‘5.7.1’

<b>Step 3:</b> Add Members from a CSV file to NoSendingMailForYou Distribution Group

<b>POWERSHELL</b>
Import-CSV FileName.csv | ForEach {Add-DistributionGroupMember -Identity "NoSendingMailForYou" -Member $_.Name}

IMPORTANT NOTE: Things to know...
=================================
<b>WHEN</b> - “no-sending distro member users” send email from their old Outlook client, it might appear to work!!
<b>HOWEVER</b> - The Hub Transport Rule WILL REJECT those messages along with a custom NDR to the sender (a.k.a. “no-sending distro member users”)

<b>NOW</b> - IF the Delivery Options are set to Forward to their Google Apps account,
	<b>AND NOT</b> delivered to the Exchange mailbox (a’.k.a. split-delivery’), 
	Then the rejection NDR message is viewable only in their Google Apps mailbox.

<b>BUT - IF</b> the Delivery Options are set to Forward to their Google Apps account,
	AND delivered to the Exchange mailbox (a’.k.a. dual-delivery’), 
	Then the rejection NDR message is viewable in their Google Apps AND Exchange accounts.
