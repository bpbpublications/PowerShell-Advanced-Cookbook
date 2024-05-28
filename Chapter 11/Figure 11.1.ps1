# Install AWS.Tools installer module (Modularized package)
Install-Module AWS.Tools.Installer

# Install module for Simple Storage Service (S3)
Install-AWSToolsModule AWS.Tools.S3

# Install module for Elastic Compute Cloud service (EC2)
Install-AWSToolsModule AWS.Tools.EC2

Import-Module AWS.Tools.S3
Import-Module AWS.Tools.EC2

Get-Module