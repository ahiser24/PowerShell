#Export a list of Teams apps that are approved.
 Connect-MicrosoftTeams
Get-teamsApp | Export-Csv "C:\temp\TeamsAppsprod.csv"
