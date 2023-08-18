#Connect to SharePoint Online Admin Center
Connect-SPOService -Url "https://mosaicco-admin.sharepoint.com"

#Import CSV file
$Sites = Import-CSV -Path "$env:USERPROFILE\Downloads\sitedeletion.csv"

#Loop through each deleted site and remove from recycle bin.
foreach ($Site in $Sites){
Write-Host "Deleting " $Site.URL
Remove-SPOSite -Identity $Site.URL -Confirm:$false
Remove-SPODeletedSite -Identity $Site.url -Confirm:$false
Write-Host $Site.url "has been deleted from the Recycle Bin"
}