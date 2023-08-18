#Collect Proc Dump Logs. Run this after the crash happened.
New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe'

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe' -Name "DumpType" -Value 2 -PropertyType DWORD

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe' -Name "DumpCount" -Value 2 -PropertyType DWORD

#Delete Registry key using the below command after logs have been gathered.
#Remove-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe'