Connect-sposervice

https://YOURSITE-admin.sharepoint.com

# Specify your organization admin central url

$AdminURI = "https://YOURSITE-admin.sharepoint.com"

# Specify the User account for an Office 365 global admin in your organization

$AdminAccount = WHOAREYOU@YOURSITE.COM

$AdminPass =

# Specify the secondary admin account and the url for the onedrive site

$secondaryadmin = "WHOAREYOU@YOURSITE.COM"

$siteURI = "https://YOURSITE-my.sharepoint.com "

$loadInfo1 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client")

$loadInfo2 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.Runtime")

$loadInfo3 = [System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SharePoint.Client.UserProfiles")

$sstr = ConvertTo-SecureString -string $AdminPass -AsPlainText -Force

$AdminPass = ""

$creds = New-Object Microsoft.SharePoint.Client.SharePointOnlineCredentials($AdminAccount, $sstr)

$UserCredential = New-Object System.Management.Automation.PSCredential -argumentlist $AdminAccount, $sstr

# Add the path of the User Profile Service to the SPO admin URL, then create a new webservice proxy to access it

$proxyaddr = "$AdminURI/_vti_bin/UserProfileService.asmx?wsdl"

$UserProfileService= New-WebServiceProxy -Uri $proxyaddr -UseDefaultCredential False

$UserProfileService.Credentials = $creds

# Set variables for authentication cookies

$strAuthCookie = $creds.GetAuthenticationCookie($AdminURI)

$uri = New-Object System.Uri($AdminURI)

$container = New-Object System.Net.CookieContainer

$container.SetCookies($uri, $strAuthCookie)

$UserProfileService.CookieContainer = $container

# Sets the first User profile, at index -1

$UserProfileResult = $UserProfileService.GetUserProfileByIndex(-1)

Write-Host "Starting- This could take a while."

$NumProfiles = $UserProfileService.GetUserProfileCount()

$i = 1

Connect-SPOService -Url $AdminURI -Credential $UserCredential

# As long as the next User profile is NOT the one we started with (at -1)...

While ($UserProfileResult.NextValue -ne -1)

{

Write-Host "Examining profile $i of $NumProfiles"

# Look for the Personal Space object in the User Profile and retrieve it

# (PersonalSpace is the name of the path to a user's OneDrive for Business site. Users who have not yet created a

# OneDrive for Business site might not have this property set.)

$Prop = $UserProfileResult.UserProfile | Where-Object { $_.Name -eq "PersonalSpace" }

$Url= $Prop.Values[0].Value

# If OneDrive is activated for the user, then set the secondary admin

if ($Url) {

$sitename = $siteURI + $Url

$temp = Set-SPOUser -Site $sitename -LoginName $secondaryadmin -IsSiteCollectionAdmin $false -ErrorAction SilentlyContinue

Write-Host "Added secondary admin to the site $($sitename)"

}

# And now we check the next profile the same way...

$UserProfileResult = $UserProfileService.GetUserProfileByIndex($UserProfileResult.NextValue)

$i++

}