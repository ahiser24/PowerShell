﻿Connect-MsolService
Get-MsolUser -All | where {$_.isLicensed -eq $true} | select DisplayName, userprincipalname, UsageLocation, islicensed, {$_.Licenses.AccountSkuId} | Export-CSV "C:\temp\teams_users.csv" –NoTypeInformation 
