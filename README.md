___
ExchangeGoodies
=
Prevent specific Exchange 2007 users from sending email<br>
<a href=https://github.com/billreed72/ExchangeGoodies/blob/master/Prevent%20Sending%20for%20SOME%20users%20in%20Exchange%202007.md target="_blank"> :-) </a>
___
Dual & Split Delivery for Exchange 2007
=

<b>Step 1:</b> Create a userList.csv file that contains 3 column headers.<br>
(i.e. firstName,lastName,alias)<br>
- Sample: <a href=https://github.com/billreed72/Exchange2007Goodies/blob/master/userList.csv-SAMPLE target="_blank">userList.csv</a>
- The names in the <b>sample</b> userList.csv are 100% fictional enerated from a handy little website I found.<a href=http://random-name-generator.info target="_blank">Random Name Generator</a>.

<b>Step 2:</b> Create <b>hidden mail enabled contacts</b>
- Ingredients: userList.csv, createMailContacts-Ex2007.ps1, hideMailContacts-Ex2007.ps1
<blockquote> Part 1: Using any text editor, edit variables within createMailContacts-Ex2007.ps1 to match your environment.<br>
From the Exchange 2007 Management Shell, execute the following:<br>
.\createMailContacts-Ex2007.ps1 </blockquote>
<blockquote> .\hideMailContacts-Ex2007.ps1 </blockquote>

<b>Step 3:</b>
