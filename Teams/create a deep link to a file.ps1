#Create Deep links to files in Teams
$TenantID = &quot;1273caf7-13b7-4a89-b44a-3967d45ba0a9&quot;
#Define file type choices
$fileTypeChoices = [System.Management.Automation.Host.ChoiceDescription[]] @((New-Object
System.Management.Automation.Host.ChoiceDescription &quot;&amp;docx&quot;),(New-Object
System.Management.Automation.Host.ChoiceDescription &quot;&amp;xlsx&quot;),(New-Object
System.Management.Automation.Host.ChoiceDescription &quot;&amp;ppt&quot;),(New-Object
System.Management.Automation.Host.ChoiceDescription &quot;&amp;pdf&quot;))
#Ask user for File URL
$fileURL = Read-Host -Prompt &quot;What is the file URL?&quot;
#Ask the user for file type
$fileTypeIndex = $host.UI.PromptForChoice(&quot;File Type&quot;, &quot;What is the file type?&quot;,$fileTypeChoices, 0)
$fileType =
$fileTypeChoices[$fileTypeIndex].Label.Trim(&quot;&amp;&quot;)
$deepLink = &quot;https://teams.microsoft.com/l/file/$fileID?tenantId=$TenantID&amp;fileType=$fileType&amp;objectUrl=$fileURL&quot;
#TO DO. Take the fileURL and separate the file ID from it