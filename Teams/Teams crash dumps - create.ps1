New-Item -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe'

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe' -Name "DumpType" -Value 2 -PropertyType DWORD

New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting\LocalDumps\Teams.exe' -Name "DumpCount" -Value 2 -PropertyType DWORD