#This script will add them to Office 365 group

Import-Module ActiveDirectory

$Users = Import-csv "C:\Scripts\Exchange_O365\Office365 migration\blockextemail.csv" -Header USer_AD

ForEach ($USer in $Users) {
	$USer1 = $user.User_AD.split('@')[0]
	Add-ADGroupMember -Identity BlockExternalEmail -Member $User1
}
