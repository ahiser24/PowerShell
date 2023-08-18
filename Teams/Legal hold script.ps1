#Get a list of Teams that contain legal hold users based on a spreadsheet.
 #Connect to Microsoft Teams
Connect-MicrosoftTeams

#Import CSV and check each user for legal hold
$emails = Import-Csv -Path "C:\Users\USER\Legal Hold Review\emails.csv"

ForEach($email in $emails) {
Get-Team -User $email.email | Select DisplayName | Export-Csv "C:\temp\legaltest.csv" -Append
}
