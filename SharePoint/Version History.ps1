#Set Variables
$SiteURL = Read-Host "What is the Site Collection Address?"
$LibraryName = Read-Host "What is the library name? example: 'Documents'"
Write-Host "The file will be saved to 'C:\Temp\VersionHistory.csv'"
$CSVPath = "C:\Temp\VersionHistory.csv"
$prefix="https://mosaicco.sharepoint.com"
  
#Connect to SharePoint Online site
Connect-PnPOnline -Url $SiteURL -UseWebLogin;
 
$VersionHistoryData = @()
#Iterate through all files
Get-PnPListItem -List $LibraryName -PageSize 100 | Where {$_.FileSystemObjectType -ne "Folder"} | ForEach-Object {

    Write-host "Getting Versioning Data of the File:"$_.FieldValues.FileRef
   
    #Get FileSize & version Size
    $FileSizeinKB = [Math]::Round(($_.FieldValues.File_x0020_Size/1KB),2)
    $File = Get-PnPProperty -ClientObject $_ -Property File
    $Versions = Get-PnPProperty -ClientObject $_ -Property Versions
    $VersionSize = $Versions.Size
    $VersionSizeinKB = [Math]::Round(($VersionSize/1KB),2)
    $TotalFileSizeKB = [Math]::Round(($FileSizeinKB + $VersionSizeinKB),2)
 
 Foreach($version in $versions)
{
    #Extract Version History data
    $VersionHistoryData+=New-Object PSObject -Property  ([Ordered]@{
        "File Name"  = $_.FieldValues.FileLeafRef
        "File URL" = $Prefix + $_.FieldValues.FileRef
        "Versions" =  $Version.VersionId/512
		"Date Created" = (Get-Date ($Version.Created) -Format "yyyy-MM-dd/HH:mm:ss")
        "File Size (KB)"  = $FileSizeinKB
    })
}}
$VersionHistoryData | Format-table -AutoSize
$VersionHistoryData | Export-Csv -Path $CSVPath -NoTypeInformation