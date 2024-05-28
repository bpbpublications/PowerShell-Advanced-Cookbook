# Expects you to be authenticated with a user with proper permissions

# Expects this user to already exist
New-IAMUser -UserName Test

# This user is not expected to exist
New-IAMUser -UserName ApiAccess
