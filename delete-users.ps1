Get-LocalUser | Where -property name -ne dtcadmin | Remove-LocalUser
