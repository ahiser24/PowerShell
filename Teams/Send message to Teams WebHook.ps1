#Admin SharePoint Site
$AdminSiteURL = "https://TENANT-admin.sharepoint.com/"

#Connect to SharePoint Online
Connect-SPOService -URL $AdminSiteURL

#Get all Deleted Sites
$bodytext = Get-SPODeletedSite -Limit 1000 | Where-Object {$_.DaysRemaining -LT 10} | select "URL","DaysRemaining" | Out-String

$text = $bodytext
$uri = "WEBHOOK"

$body = ConvertTo-JSON @{
    text = $bodytext
}

Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'
