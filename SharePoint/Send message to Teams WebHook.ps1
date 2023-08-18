#Admin SharePoint Site
$AdminSiteURL = "https://mosaicco-admin.sharepoint.com/"

#Connect to SharePoint Online
Connect-SPOService -URL $AdminSiteURL

#Get all Deleted Sites
$bodytext = Get-SPODeletedSite -Limit 1000 | Where-Object {$_.DaysRemaining -LT 10} | select "URL","DaysRemaining" | Out-String

$text = $bodytext
$uri = "https://outlook.office.com/webhook/d4127eb3-74b3-4e29-9846-86047418909c@1273caf7-13b7-4a89-b44a-3967d45ba0a9/IncomingWebhook/0917d9d24dcd4fd895fe7669579b3a16/06319cf8-dde7-4e82-8c6d-30e51da9a6cf"

$body = ConvertTo-JSON @{
    text = $bodytext
}

Invoke-RestMethod -uri $uri -Method Post -body $body -ContentType 'application/json'