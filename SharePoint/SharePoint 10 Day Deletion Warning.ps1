#Admin SharePoint Site
$AdminSiteURL = "https://contoso-admin.sharepoint.com/"

#Connect to SharePoint Online
Connect-SPOService -URL $AdminSiteURL

#Get Date for file output
$filename = (Get-Date).ToString("MMddyyyy") + '.htm'

#Get all Deleted Sites and Output as a .htm file
$saveLocation = "$($env:USERPROFILE)\Documents\Scripts\SharePoint\Upload\" + $filename
$bodytext = Get-SPODeletedSite -Limit 1000 | Where-Object {$_.DaysRemaining -LT 10} | select "URL","DaysRemaining" | ConvertTo-Html | Out-File ($saveLocation)

#Move file to Teams folder
$URL = "https://contoso.sharepoint.com/sites/subsite"
$SubFolder = "Shared Documents/O365 Cleanup/10 Day Deletion Warning/2021"
Import-Module PnP.PowerShell 
Connect-PnPOnline $URL -UseWebLogin

$Files = Get-ChildItem "C:\Users\USER\Documents\Scripts\SharePoint\Upload"
foreach($File in $Files){
    #$File = $Files[0]
    Add-PnPFile -Folder $SubFolder -Path $File.FullName
}
#Delete Source Files
Remove-Item C:\Users\USER\Documents\Scripts\SharePoint\Upload\*.*