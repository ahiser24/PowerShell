#This script will take all files in a specified folder and upload them to a specific folder/subfolder in SharePoint and 
#overwrite with a new version
#URL = URL of root site
#SubFolder = Subsite folder location starting with Shared Documents
#SourceFiles = Folder location with files to upload to SharePoint

$URL = "https://mosaicco.sharepoint.com/sites/Ent-TestClientServicesIT-Ent2"
$SubFolder = "Shared Documents/test2/PowerShell"
$SourceFiles = "C:\Users\ahiser\Downloads\upload"

#Install-Module PnP.PowerShell if not already installed
Import-Module PnP.PowerShell 

#Connect to site
Connect-PnPOnline $URL -UseWebLogin

#Upload Source Files into SharePoint Site
$Files = Get-ChildItem $SourceFiles
foreach($File in $Files){
    #$File = $Files[0]
    Add-PnPFile -Folder $SubFolder -Path $File.FullName
}