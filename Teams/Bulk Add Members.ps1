#Bulk add a list of users to a Team via email addresses.
#Create a .csv file called "contacts.csv" with a list of the emails and save it to the Downloads folder.

#Connect to Microsoft Teams Admin Center
Connect-MicrosoftTeams

#Get Team ID
$TeamName = Read-Host 'Enter the Name of the Team'
$GetTeam = Get-Team -DisplayName $TeamName
$GroupID = $GetTeam.GroupID

#Imports contacts.csv (Make sure CSV file is located in the Downloads folder)
Import-Csv -Path "$env:USERPROFILE\Downloads\bulk.txt" | foreach{Add-TeamUser -GroupId "$GroupID" -user $_.email}