    Connect-MSOLService
    
    $users = get-content -path "C:\scripts\Exchange_O365\Licenses\ChangeLicenses.txt"

    $SKU_OF1="contoso:DESKLESSPACK" # Office 365 F1
    $SKU_OE3="contoso:ENTERPRISEPACK" # Office 365 E3 (preferred)

    $SKU_MF1="contoso:SPE_F1" # Microsoft 365 F1 (preferred)
    $SKU_ME3="contoso:SPE_E3" # Microsoft 365 E3

    foreach ($user in $users)
    { 
        Set-MsolUserLicense -UserPrincipalName $user -RemoveLicenses $SKU_OF1
        Set-MsolUserLicense -UserPrincipalName $user -AddLicenses $SKU_MF1
        Get-MsolUser -UserPrincipalName $user | fL UserPrincipalName, DisplayName, IsLicensed, Licenses
         
    }