Old Option:
===========
Turing the quota down with/without turning off local delivery check box... ick!<br>
<b>Problem:</b> Can cause mail to fail delivery.

Newer/Better Option
===================
<b>Requirements:</b><br>

<ol>
<li>stop local delivery<br>
<li>stop user from sending<br>
<li>Allow users to access old Exchange mail but not send<br>
</ol>

<br>
<b>Step 1:</b> Create a new Distribution Group<br>

<ul>
<li>Members will be restricted from sending emails<br>
<li>Must be a universal group<br>
</ul>

<br>
<b>Powershell</b><br>
<blockquote>new-DistributionGroup -Name ’NoSendingMailForYou’ -Type ‘Distribution’ -SamAccountName ’NoSendingMailForYou’ -Alias ‘NoSendingMailForYou’</blockquote>

<b>Step 2:</b> Create a new Transport Rule<br>

<ul>
<li>Conditions:
</ul>

<ul>
<li>From members of a distribution list<br>
<li>Choose the new distribution group<br>
</ul>

<ul>
<li>Actions:
</ul>

<ul>
<li>Send rejection message to sender with enhanced status code<ul><br>
Message: <br>
<blockquote>“Please login to your new Google Apps account.<br>
The URL is http://www.google.com.<br>
You are no longer authorized to send email from this system.<br>
For support, contact our helpdesk at 714-555-1234.”<br></blockquote>
</ul>

<b>Powershell</b><br>
<blockquote>New-TransportRule -Name ’PreventSending’ -Comments ‘’ -Priority ‘0’	-Enabled $true -FromMemberOf ‘NoSendingMailForYou@contoso.com’ -RejectMessageReasonText ‘Please login to your new Google Apps account. The URL is http://www.google.com. You are no longer authorized to send email from this system. For support, contact our helpdesk at 714-555-1234.’ -RejectMessageEnhancedStatusCode ‘5.7.1’</blockquote>

<b>Step 3:</b> Add Members from a CSV file to NoSendingMailForYou Distribution Group<br>

<b>Powershell</b><br>
<blockquote>Import-CSV FileName.csv | ForEach {Add-DistributionGroupMember -Identity "NoSendingMailForYou" -Member $_.Name}</blockquote>

IMPORTANT NOTE: Things to know...
=================================
<b>WHEN</b> - “no-sending distro member users” send email from their old Outlook client, it might appear to work!!<br>
<b>HOWEVER</b> - The Hub Transport Rule WILL REJECT those messages along with a custom NDR to the sender (a.k.a. “no-sending distro member users”)<br>
<b>NOW</b> - IF the Delivery Options are set to Forward to their Google Apps account,<br>
	<b>AND NOT</b> delivered to the Exchange mailbox (a’.k.a. split-delivery’), <br>
	Then the rejection NDR message is viewable only in their Google Apps mailbox.<br>
<b>BUT - IF</b> the Delivery Options are set to Forward to their Google Apps account,<br>
	AND delivered to the Exchange mailbox (a’.k.a. dual-delivery’), <br>
	Then the rejection NDR message is viewable in their Google Apps AND Exchange accounts.<br>
