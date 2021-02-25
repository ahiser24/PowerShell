#Get User for AutoReply
Write-Host "Type in the network account or email address that needs an OOO message"
$alias = Read-Host -Prompt 'Account or Email'

Write-Host "Input the OOO message for interal emails"
$Internal = Read-Host -Prompt 'Input Message'

Write-Host "Input the OOO message for external emails"
$External = Read-Host -Prompt 'Input Message'

#Run command to change auto reply
Set-MailboxAutoReplyConfiguration -Identity $alias -AutoReplyState Enabled -InternalMessage "$Internal" -ExternalMessage "$External"