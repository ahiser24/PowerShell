    Connect-MSOLService

    $users = import-csv "\\exmb01\c$\Temp\Office365 Migration\NeedBothTESTMigrationFinal.csv" -delimiter "," 
    
    $usagelocation="US"

    $SKU_OF1="contoso:DESKLESSPACK" # Office 365 F1
    $SKU_OE3="contoso:ENTERPRISEPACK" # Office 365 E3 (preferred)

    $SKU_MF1="contoso:SPE_F1" # Microsoft 365 F1 (preferred)
    $SKU_ME3="contoso:SPE_E3" # Microsoft 365 E3

    foreach ($user in $users)
    { 
        $upn=$user.EmailAddress 
        Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation 
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU_MF1
        Get-MsolUser -UserPrincipalName $upn | ft
         
    } 