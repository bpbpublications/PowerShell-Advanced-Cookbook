# Create AD user manually using script
.\CreateADUser.ps1 `
-GivenName "john" `
-SurName "Wilkins" `
-JobTitle "Senior Developer" `
-Department "Development" `
-Country "DK" `
-MobilePhone "+4532165487" `
-Verbose


############################################

# Get content of password file
Get-Content .\jowi.txt

############################################

# Get AD user after creation
Get-ADUser jowi `
-Properties EmailAddress,Title,Department,Country,Company,MemberOf,PasswordExpired