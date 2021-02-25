    Connect-MSOLService

    $users = import-csv "\\exmb01\c$\Temp\Office365 Migration\NeedBothTESTMigrationFinal.csv" -delimiter "," 
    
    $usagelocation="US"

    $SKU_OF1="badcock:DESKLESSPACK" # Office 365 F1
    $SKU_OE3="badcock:ENTERPRISEPACK" # Office 365 E3 (preferred)

    $SKU_MF1="badcock:SPE_F1" # Microsoft 365 F1 (preferred)
    $SKU_ME3="badcock:SPE_E3" # Microsoft 365 E3

    foreach ($user in $users)
    { 
        $upn=$user.EmailAddress 
        Set-MsolUser -UserPrincipalName $upn -UsageLocation $usagelocation 
        Set-MsolUserLicense -UserPrincipalName $upn -AddLicenses $SKU_MF1
        Get-MsolUser -UserPrincipalName $upn | ft
         
    } 