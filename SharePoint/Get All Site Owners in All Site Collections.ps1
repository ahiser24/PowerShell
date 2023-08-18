Connect-SPOService

$AllSites = Get-SPOSite -Limit ALL

Foreach($site in $AllSites){
Write-Host $site.Url
$Groups = Get-SPOSiteGroup -Site $site.Url
Foreach($Group in $Groups){
Foreach($Role in $Group.Roles){
If ($Role.Contains(“Full Control”))
{
Write-Host $Group.Title
Write-Host $Group.Users
$users = $Group.Users -join ‘ ‘
$title = $Group.Title
$props = @{Title = $title
Users = $users
Website = $site.Url}
$temp = New-Object psobject -Property $props
$temp | export-csv –append –path C:\temp\SiteOwnerandSites.csv
}
}}}