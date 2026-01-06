
# Requires: MicrosoftTeams module (Preview features for some cmdlets)
Import-Module MicrosoftTeams
Connect-MicrosoftTeams

$teamName = Read-Host "What is the Team name?"
$teamChannel = Read-Host "What is the channel name?"

# Identify the team and its private channel
$team    = Get-Team -DisplayName $teamName
$channel = Get-TeamChannel -GroupId $team.GroupId -MembershipType Private |Where-Object DisplayName -eq $teamChannel

# Get users in the private channel and export
$members = Get-TeamChannelUser -GroupId $team.GroupId -DisplayName $channel.DisplayName
$members | Select-Object Name, User, Role |
    Export-Csv -Path "$env:USERPROFILE\Downloads\PrivateChannelMembers.csv" -NoTypeInformation -Encoding UTF8
