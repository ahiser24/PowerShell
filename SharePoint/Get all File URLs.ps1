 Write-Host "example: https://mosaicco.sharepoint.com/sites/MySharePointSite"
 $SiteURL = Read-Host "Please enter the SharePoint URL"
 
 #Set Variables
 $ListName="Documents"
 $prefix="https://mosaicco.sharepoint.com"
 $URLSplit = $SiteURL.Split('/')[-1]
 $endURL = "/sites/"+$URLSplit
    
 #Connect to PNP Online
 Connect-PnPOnline –Url $SiteURL -UseWebLogin;
     
 #Get All Items from the specific folder - In batches of 500
 $ListItems = Get-PnPListItem -List $ListName -FolderServerRelativeUrl $endURL -PageSize 500
     
 #Loop through List Items and Get File URL
 $Results=@()
 ForEach($Item in $ListItems)
 {
     $Results += New-Object PSObject -Property @{
     FileName =   $Item.FieldValues['FileLeafRef']
     FileURL = $prefix + $Item.FieldValues['FileRef']
     }
 }
$Results | Export-Csv C:\temp\FileURL.csv
