$TeamName = Read-Host "What is the name of the Team?" 
$channelName="General"  
$tenantId= (Connect-MicrosoftTeams).TenantID
 
# Get the team  
$team=Get-Team -DisplayName $teamName  
 
# Get the Group Id  
$groupID = $team.GroupId  
 
# Get the channel  
$channel = Get-TeamChannel -GroupId $groupID | Where-Object {$_.DisplayName -eq $channelName}  
 
# Get the channel ID  
$channelId = $channel.Id  
 
# Get the Team link  
$teamLink = "https://teams.microsoft.com/l/team/"+$channelId+"/conversations?groupId="+$groupID+"&tenantId="+$tenantId;
$teamLink | Set-Clipboard
Write-Host -F Green $teamLink
Write-Host -F Green "URL Copied to Clipboard"
Write-Host -F Yellow "Press enter to view the GroupID"
Pause

Write-Host -F Red $groupID
Write-Host -F Green "GroupID Copied to Clipboard"
$groupID | Set-Clipboard