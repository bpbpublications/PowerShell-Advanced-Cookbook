# Install AWS.Tools installer module (Modularized package)
Install-Module AWS.Tools.Installer

# Install module for Simple Storage Service (S3)
Install-AWSToolsModule AWS.Tools.S3

# Install module for Elastic Compute Cloud service (EC2)
Install-AWSToolsModule AWS.Tools.EC2

# Configure credentials using Environment variables
$Env:AWS_ACCESS_KEY_ID="AKIA5V67JFUTZOF4UQNQ"
$Env:AWS_SECRET_ACCESS_KEY="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"
$Env:AWS_DEFAULT_REGION="eu-north-1"

# Configure credentials using the Set-AWSCredentials cmdlet
Set-AWSCredentials `
-AccessKey "AKIA5V67JFUTZOF4UQNQ" `
-SecretKey "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"

# Specify credentials for a single cmdlet
Get-S3Bucket `
-AccessKey "AKIA5V67JFUTZOF4UQNQ" `
-SecretKey "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"

# Specify credentials using credentials file
# %USERPROFILE%\.aws\credentials
# Create the directory/file if it does not exist.
# New-Item -Path "$($env:USERPROFILE)\.aws\credentials" -ItemType file -Force
# Add the following lines to the file (without #)
# [default]
# aws_access_key_id = AKIA5V67JFUTZOF4UQNQ
# aws_secret_access_key = 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
# You can use ENV VAR to change the PATH to the credentials file:
# $ENV:AWS_SHARED_CREDENTIALS_FILE="C:\NewPathTo\credentials"