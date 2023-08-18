Connect-SPOService -Url "https://mosaicco-admin.sharepoint.com"
Get-SPOSite -Limit "All" -IncludePersonalSite $True | Export-Csv -Path "C:\temp\SiteListing.csv"