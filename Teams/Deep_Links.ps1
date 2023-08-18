#Create Deep links to files in Teams

#Tenant ID
$TenantID = "TENANT_ID"

#Define file type choices
$fileTypeChoices = [System.Management.Automation.Host.ChoiceDescription[]] @(
    (New-Object System.Management.Automation.Host.ChoiceDescription "&docx"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&xlsx"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&csv"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&ppt")
)

#Ask user for File URL
$fileURL = Read-Host -Prompt "What is the file URL?"
$fileID = $fileURL.split("?")[0].split("/")[-1]

#Ask the user for file type
$fileTypeIndex = $host.UI.PromptForChoice("File Type", "What is the file type?", $fileTypeChoices, 0)

#Trim fileURL to get the fileID
$fileType = $fileTypeChoices[$fileTypeIndex].Label.Trim("&")

#Put the information together into a deep link
$deeplink = "https://teams.microsoft.com/l/file/" + $fileID + "?tenantId=$TenantID&fileType=$fileType&objectUrl=$fileURL"

#Return the deep link
Write-Host "The deep link to your file is $deepLink"

#Copy the deep link to clipboard
$deeplink | Set-Clipboard

#Pause script for user
Pause
