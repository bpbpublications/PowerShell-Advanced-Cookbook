# Recipe: AWS EC2 Instance Management
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates complete EC2 instance lifecycle including key pairs,
# security groups, instance creation, and SSH access.

# ============================================================================
# CONFIGURATION
# ============================================================================

$Region = "eu-north-1"

# ============================================================================
# CREATE KEY PAIR FOR SSH ACCESS
# ============================================================================

# Create a new Key Pair for SSH authentication
# RSA key in PEM format for compatibility with SSH clients
$SSHKey = New-EC2KeyPair -KeyName "SSHKey" `
    -KeyType rsa `
    -KeyFormat pem `
    -Region $Region

# Save the Private Key to a file
# IMPORTANT: This is the only time you can retrieve the private key!
$SSHKey.KeyMaterial | Out-File C:\Temp\SSHKey.pem

# On Linux/Mac, set proper permissions: chmod 400 ~/SSHKey.pem

# ============================================================================
# CREATE EC2 INSTANCE
# ============================================================================

# Create an EC2 instance using an Ubuntu AMI
$EC2 = New-EC2Instance `
    -ImageId "ami-0fe8bec493a81c7da" `
    -InstanceType "t3.micro" `
    -KeyName $SSHKey.KeyName `
    -Region $Region

# Wait for instance to initialize and get its public IP
# Start-Sleep -Seconds 2
$PublicIP = ($EC2 | Get-EC2Instance -Region $Region).Instances.PublicIPAddress
$Username = "ubuntu"

# ============================================================================
# CONFIGURE SECURITY GROUP FOR SSH
# ============================================================================

# Get the security group ID assigned to the instance
$SECGroupID = ($EC2 | Get-EC2Instance -Region $Region).Instances.SecurityGroups.GroupID

# Get your current public IP address
$MyIP = (Invoke-RestMethod "http://httpbin.org/ip").origin

# Create an ingress rule to allow SSH (port 22) from your IP only
$IpPermission = @{
    "IpProtocol" = "tcp"
    "FromPort"   = 22
    "ToPort"     = 22
    "IpRanges"   = "$MyIP/32"
}

# Add the rule to the security group
Grant-EC2SecurityGroupIngress `
    -GroupId $SECGroupID `
    -IpPermission $IpPermission `
    -Region $Region

# ============================================================================
# SEARCH FOR AMIs
# ============================================================================

# Create a filter to find specific AMIs (Amazon Linux 2 example)
$Filter = @{
    Name = "architecture"; Values = "x86_64"
}, @{
    Name = "description"; Values = "Amazon Linux 2 AMI*"
}, @{
    Name = "is-public"; Values = "true"
}, @{
    Name = "state"; Values = "available"
}

# ============================================================================
# SEARCH FOR INSTANCE TYPES
# ============================================================================

# List all available instance types in the region
Get-EC2InstanceType -Region $Region

# Find instance types with specific requirements (GPU example)
Get-EC2InstanceType -Region $Region |
    Where-Object {
        $_.VCpuInfo.DefaultVCpus -eq 8 `
            -and $_.MemoryInfo.SizeInMib -ge 24576 `
            -and $_.GpuInfo.TotalGpuMemoryInMiB -ge 24576
    }

# Find small instance types (2 vCPU, 1GB RAM)
Get-EC2InstanceType -Region $Region |
    Where-Object {
        $_.VCpuInfo.DefaultVCpus -eq 2 `
            -and $_.MemoryInfo.SizeInMib -eq 1024
    }

# ============================================================================
# SSH CONNECTION
# ============================================================================

# Connect to a Linux instance using SSH
# Syntax: ssh -i <PathToPrivateKey.pem> username@<PublicIP>
ssh -i <PathToPrivateKey.pem file> ubuntu@<PublicIpForEC2Instance>
ssh -i C:\Temp\SSHKey.pem ubuntu@123.10.10.123

# ============================================================================
# WINDOWS INSTANCE PASSWORD RETRIEVAL
# ============================================================================

# Decrypt Windows administrator password using key pair
$InstanceId = "YourInstanceId"
$PasswordData = Get-EC2PasswordData -InstanceId $InstanceId -KeyPair "YourKeyPairName"
$DecryptedPassword = [System.Text.Encoding]::UTF8.GetString(
    [System.Convert]::FromBase64String($PasswordData.PasswordData)
)
Write-Output $DecryptedPassword

# ============================================================================
# DISCOVER EC2 INSTANCE CMDLETS
# ============================================================================

# List EC2 Instance relevant cmdlets
Get-Command | Where-Object { $_.Name -match "EC2Instance" }

# ============================================================================
# INSTANCE QUERIES
# ============================================================================

# List all EC2 Instances in your account/Region
Get-EC2Instance -Region eu-north-1

# List all EC2 instances with their instance properties
(Get-EC2Instance -Region eu-north-1).Instances

# Get instance ID for a specific instance (from variable)
$InstanceID = $EC2.Instances.InstanceId

# ============================================================================
# INSTANCE LIFECYCLE MANAGEMENT
# ============================================================================

# Stop EC2 Instance
Stop-EC2Instance -Region $Region -InstanceId $InstanceId

# Start EC2 Instance
Start-EC2Instance -Region $Region -InstanceId $InstanceId

# Restart EC2 Instance (graceful reboot)
Restart-EC2Instance -Region $Region -InstanceId $InstanceId

# Reset EC2 Instance (hard reset)
Reset-EC2Instance -Region $Region -InstanceId $InstanceId

# Terminate and remove EC2 Instance
Remove-EC2Instance -Region $Region -InstanceId $InstanceId

# Terminate without confirmation prompt
Remove-EC2Instance -Region $Region -InstanceId $InstanceId -Confirm:$false

# ============================================================================
# NOTES
# ============================================================================

# Instance States:
# - pending: Instance is launching
# - running: Instance is running and accessible
# - stopping: Instance is stopping
# - stopped: Instance is stopped (no charges for compute, storage still charged)
# - shutting-down: Instance is terminating
# - terminated: Instance is deleted
#
# Key Pair Best Practices:
# - Create separate key pairs for different purposes/environments
# - Store private keys securely (encrypted, access-controlled)
# - Rotate keys periodically
# - Never share private keys
