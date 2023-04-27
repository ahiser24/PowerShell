#Create Deep links to files in Teams
$TenantID = "1273caf7-13b7-4a89-b44a-3967d45ba0a9"
#Define file type choices
$fileTypeChoices = [System.Management.Automation.Host.ChoiceDescription[]] @(
    (New-Object System.Management.Automation.Host.ChoiceDescription "&docx"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&xlsx"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&ppt"),
    (New-Object System.Management.Automation.Host.ChoiceDescription "&pdf")
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
#Return the deep link & copy it to the clipboard
Write-Host "The deep link to your file is $deepLink"
$deeplink | Set-Clipboard
