#Connect to Teams Admin Center
Connect-MicrosoftTeams

#Get list of users
$users = Get-Content -Path "C:\users\USER\Downloads\meeting_policy_bulk.txt"

#Grant specific Teams Meeting Policy. Change Policy Name to fit.
Import-Csv -Path "$env:USERPROFILE\Downloads\premium.txt" | foreach{Grant-CsTeamsMeetingPolicy -Identity $_.email -PolicyName "Teams Premium Pilot"}
