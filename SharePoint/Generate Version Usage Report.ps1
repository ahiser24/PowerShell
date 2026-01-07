# Connect to SPO Admin
$AdminUrl = 'https://mosaicco-admin.sharepoint.com'
Connect-SPOService -Url $AdminUrl

# Input Site URL for Report (e.g., https://contoso.sharepoint.com/sites/TeamA)
$siteUrl = Read-Host "Enter the full site URL"

# Build a default ReportUrl under the root Documents library
# Server-relative path for the default library is /Shared Documents
# We'll place the report in a 'Reports' subfolder and avoid collisions with a timestamped filename
$timestamp  = Get-Date -Format "yyyyMMdd-HHmmss"
$reportFile = "VersionReport-$timestamp.csv"
$reportUrl  = "$siteUrl/Shared Documents/Reports/$reportFile"

# Queue the version storage usage report for the site
New-SPOSiteFileVersionExpirationReportJob -Identity $siteUrl -ReportUrl $reportUrl

Write-Host "Queued report generation. Report will be saved to:" -ForegroundColor Cyan
Write-Host $reportUrl
Write-Host "Note: The job runs asynchronously and may take 24 hours or more depending on site size." -ForegroundColor Yellow

# Check progress on the report generation
#Get-SPOSiteFileVersionExpirationReportJobProgress -Identity $siteUrl -ReportUrl $reportUrl
