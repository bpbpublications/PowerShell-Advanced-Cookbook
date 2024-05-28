# Create an EC2 instance (Linux)

$Region = "eu-north-1"

# Create a new Key Pair 
$SSHKey = New-EC2KeyPair -KeyName "SSHKey" `
-KeyType  rsa `
-KeyFormat pem `
-Region $Region

# Save the Private Key to a file
$SSHKey.KeyMaterial | Out-File C:\Temp\SSHKey.pem

# Create an EC2 instance
$EC2 = New-EC2Instance `
-ImageId "ami-0fe8bec493a81c7da" `
-InstanceType "t3.micro" `
-KeyName $SSHKey.KeyName `
-Region $Region

#Start-Sleep -Seconds 2
$PublicIP = ($EC2 | Get-EC2Instance -Region $Region).Instances.PublicIPAddress
$Username = "ubuntu"

$SECGroupID = ($EC2 | Get-EC2Instance -Region $Region).Instances.SecurityGroups.GroupID


$MyIP = (Invoke-RestMethod "http://httpbin.org/ip").origin

$IpPermission = @{
    "IpProtocol" = "tcp"
    "FromPort" = 22
    "ToPort" = 22
    "IpRanges" = "$MyIP/32"
}

Grant-EC2SecurityGroupIngress `
-GroupId $SECGroupID `
-IpPermission $IpPermission `
-Region $Region

$Filter = @{
    Name = "architecture"; Values = "x86_64"
}, @{
    Name = "description"; Values = "Amazon Linux 2 AMI*"
}, @{
    Name = "is-public"; Values = "true"
}, @{
    Name = "state"; Values = "available"
}

# Search for instance types
Get-EC2InstanceType -Region $Region
Get-EC2InstanceType -Region $Region | `
Where-Object { 
    $_.VCpuInfo.DefaultVCpus -eq 8 `
    -and $_.MemoryInfo.SizeInMib -ge 24576 `
    -and $_.GpuInfo.TotalGpuMemoryInMiB -ge 24576
}

Get-EC2InstanceType -Region $Region | `
Where-Object { 
    $_.VCpuInfo.DefaultVCpus -eq 2 `
    -and $_.MemoryInfo.SizeInMib -eq 1024
}

# Connect to a Linux instance using SSH
ssh -i <PathToPrivateKey.pem file> ubuntu@<PublicIpForEC2Instance>
ssh -i C:\Temp\SSHKey.pem ubuntu@123.10.10.123

# Decrypt Windows administrator password using key pair
$InstanceId = "YourInstanceId"
$PasswordData = Get-EC2PasswordData -InstanceId $InstanceId -KeyPair "YourKeyPairName"
$DecryptedPassword = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($PasswordData.PasswordData))
Write-Output $DecryptedPassword

# List EC2Instance relevant cmdlets
Get-Command | Where-Object {$_.Name -match "EC2Instance"}

# List all EC2 Instances in your account/Region
Get-EC2Instance -Region eu-north-1

# List all EC2 instances and there instance properties
(Get-EC2Instance -Region eu-north-1).Instances

# Get instance iD for specific instance (referenced in a variable)
$InstanceID = $EC2.Instances.InstanceId

# Stop EC2 Instance
Stop-EC2Instance -Region $Region -InstanceId $InstanceId

# Start EC2 Instance
Start-EC2Instance -Region $Region -InstanceId $InstanceId

# Restart EC2 Instance
Restart-EC2Instance -Region $Region -InstanceId $InstanceId

# Reset EC2 Instance
Reset-EC2Instance -Region $Region -InstanceId $InstanceId

# Terminate and remove EC2 Instance
Remove-EC2Instance -Region $Region -InstanceId $InstanceId

# Terminate and remove EC2 Instance without confirmation prompt
Remove-EC2Instance -Region $Region -InstanceId $InstanceId -Confirm:$false
