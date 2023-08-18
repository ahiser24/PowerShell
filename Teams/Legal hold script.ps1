#Connect to Microsoft Teams
Connect-MicrosoftTeams

#Import CSV and check each user for legal hold
$emails = Import-Csv -Path "C:\Users\ahiser\OneDrive - The Mosaic Company\Documents\Teams\Legal Hold Review\emails.csv"

ForEach($email in $emails) {
Get-Team -User $email.email | Select DisplayName | Export-Csv "C:\temp\legaltest.csv" -Append
}
