#This script connects to the Microsoft Teams Admin center. It prompts you to enter the full name of a Team. It will then return the URL for that Team.


#Connect to Microsoft Teams  
Connect-MicrosoftTeams

# Input Parameters  
$teamName= Read-Host "Team Name"  
$channelName="General"   
 
 
# Get the tenant ID  
$tenantId=$connectTeams.TenantId  
 
# Get the team  
$team=Get-Team -DisplayName $teamName  
 
# Get the Group Id  
$groupID=$team.GroupId  
 
# Get the channel  
$channel=Get-TeamChannel -GroupId $groupID | Where-Object {$_.DisplayName -eq $channelName}  
 
# Get the channel ID  
$channelId=$channel.Id  
 
# Get the Team link  
$teamLink= "https://teams.microsoft.com/l/team/"+$channelId+"/conversations?groupId="+$groupID+"&tenantId="+$tenantId;  
Write-Host -F Green $teamLink  