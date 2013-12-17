Old Option:
===========
Turing the quota down with/without turning off local delivery check box... ick!<br>
<b>Problem:</b> Can cause mail to fail delivery.

Newer/Better Option
===================
<b>Requirements:</b><br>
<ol><li>stop local delivery
<li>stop user from sending
<li>Allow users to access old Exchange mail but not send</ol><br>
<b>Step 1:</b> Create a new Distribution Group<br>
<ul><li>Members will be restricted from sending emails
<li>Must be a universal group<br></ul><br>
<b>Powershell</b><br>
<span style="color:red">
new-DistributionGroup -Name ’NoSendingMailForYou’ -Type ‘Distribution’ -SamAccountName ’NoSendingMailForYou’ -Alias ‘NoSendingMailForYou’
</span>
<br>
<b>Step 2:</b> Create a new Transport Rule<br>
<b>Conditions:</b><br>
<ul><li>From members of a distribution list
<li>Choose the new distribution group</ul><br>
<b>Actions:</b>
<ul><li>Send rejection message to sender with enhanced status code</ul><br>
<b>Message: </b><br>
<blockquote>“Please login to your new Google Apps account.<br>
The URL is http://www.google.com.<br>
You are no longer authorized to send email from this system.<br>
For support, contact our helpdesk at 714-555-1234.”<br></blockquote><br>
<b>Powershell</b><br>
<blockquote>New-TransportRule -Name ’PreventSending’ -Comments ‘’ -Priority ‘0’	-Enabled $true -FromMemberOf ‘NoSendingMailForYou@contoso.com’ -RejectMessageReasonText ‘Please login to your new Google Apps account. The URL is http://www.google.com. You are no longer authorized to send email from this system. For support, contact our helpdesk at 714-555-1234.’ -RejectMessageEnhancedStatusCode ‘5.7.1’</blockquote><br>
<b>Step 3:</b> Add Members from a CSV file to NoSendingMailForYou Distribution Group<br>
<b>Powershell</b><br>
<blockquote>Import-CSV FileName.csv | ForEach {Add-DistributionGroupMember -Identity "NoSendingMailForYou" -Member $_.Name}</blockquote>

Things to know...
=================================
<ul><li><b>WHEN</b> - “no-sending distro member users” send email from their old Outlook client, it might appear to work!!
<li><b>HOWEVER</b> - The Hub Transport Rule WILL REJECT those messages along with a custom NDR to the sender (a.k.a. “no-sending distro member users”)
<li><b>NOW</b> - IF the Delivery Options are set to Forward to their Google Apps account,<br>
<b>AND NOT</b> delivered to the Exchange mailbox (a’.k.a. split-delivery’), <br>
Then the rejection NDR message is viewable only in their Google Apps mailbox.<br>
<li><b>BUT - IF</b> the Delivery Options are set to Forward to their Google Apps account,<br>
	AND delivered to the Exchange mailbox (a’.k.a. dual-delivery’), <br>
	Then the rejection NDR message is viewable in their Google Apps AND Exchange accounts.</ul><br>
