# Create a new user and enable programmatic/Api access
New-IAMUser -UserName NoConsoleAccess

New-IAMAccessKey -UserName NoConsoleAccess