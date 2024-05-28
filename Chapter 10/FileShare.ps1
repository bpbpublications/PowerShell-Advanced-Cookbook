# Create a file share
az storage share create `
--account-name $StorageName `
--account-key $StorageKey `
--name "myshare" `
--quota 5

# List file shares
az storage share list `
--account-name $StorageName `
--account-key $StorageKey

# Generate SAS token for file share
az storage share generate-sas `
--account-name $StorageName `
--account-key $StorageKey `
--name "myshare" `
--permissions "lrw" `
--expiry "2023-12-31T23:59:59Z"

# Map a file share to a local drive
# 1: Create a Credential Object
$Pwd = $StorageKey | Convertto-SecureString -AsPlainText -force
$Username = $StorageName
$Creds = New-Object PSCredential -ArgumentList $Username, $Pwd

# 1.1: Save the password so the drive will persist on reboot
cmd.exe /C "cmdkey /add:`"$StorageName.file.core.windows.net`" /user:`"localhost\$StorageName`" /pass:`"$StorageKey`""

# 2: Map the drive locally
New-PSDrive -Name "Z" `
-PSProvider FileSystem `
-Root "\\$StorageName.file.core.windows.net\myshare" `
-Credential $Creds `
-Persist

# 3. Remove PS drive
Remove-PSDrive -Name "Z"

# Delete a file share
az storage share delete `
--account-name $StorageName `
--account-key $StorageKey `
--name "myshare"