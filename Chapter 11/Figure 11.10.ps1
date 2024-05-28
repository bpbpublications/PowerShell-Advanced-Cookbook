# Expects you to be authenticated with a user with proper permissions


# This user is not expected to exist
# Create a new user and enable Console access and set a password
New-IAMUser -UserName ConsoleAccess

New-IAMLoginProfile -UserName ConsoleAccess `
-PasswordResetRequired $true `
-Password "New@Password"