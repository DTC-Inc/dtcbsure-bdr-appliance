New-Item -Path D:\Backups -name cloudberry -itemtype directory
New-Item -Path D:\Backups -name storagecraft -itemtype directory
New-Item -Path D:\Backups -name duplicati -itemtype directory
New-Item -Path D:\ -name repo -itemtype directory
New-SmbShare -Name "Backups" -Path D:\Backups -FullAccess "Administrator", "dtcadmin"