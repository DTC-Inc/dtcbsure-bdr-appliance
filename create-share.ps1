New-Item -path D:\Backups -name cloudberry -itemtype directory
New-Item -path D:\Backups -name storagecraft -itemtype directory
New-Item -path D:\Backups -name duplicati -itemtype directory
New-Item -path D:\ -name repo -itemtype directory
New-SmbShare -Name "Backups" -path D:\Backups -fullAccess "Administrator", "dtcadmin"