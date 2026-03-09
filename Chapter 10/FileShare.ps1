# Recipe: Azure File Share Operations
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (CLI) / Windows (drive mapping)
# Demonstrates Azure file share creation, SAS tokens, and drive mapping.

# ============================================================================
# PREREQUISITES
# ============================================================================

# Assumes $StorageName and $StorageKey are set from previous operations
# Run StorageAccounts.ps1 or BlobContainers.ps1 first to set these variables

# ============================================================================
# CREATE FILE SHARE
# ============================================================================

# Create a file share with 5 GB quota
az storage share create `
    --account-name $StorageName `
    --account-key $StorageKey `
    --name "myshare" `
    --quota 5

# ============================================================================
# LIST FILE SHARES
# ============================================================================

# List all file shares in the storage account
az storage share list `
    --account-name $StorageName `
    --account-key $StorageKey

# ============================================================================
# GENERATE SAS TOKEN
# ============================================================================

# Generate a Shared Access Signature for the file share
# Permissions: l=list, r=read, w=write
az storage share generate-sas `
    --account-name $StorageName `
    --account-key $StorageKey `
    --name "myshare" `
    --permissions "lrw" `
    --expiry "2023-12-31T23:59:59Z"

# ============================================================================
# MAP FILE SHARE AS NETWORK DRIVE (WINDOWS)
# ============================================================================

# Step 1: Create a credential object
$Pwd = $StorageKey | ConvertTo-SecureString -AsPlainText -Force
$Username = $StorageName
$Creds = New-Object PSCredential -ArgumentList $Username, $Pwd

# Step 1.1: Save credentials so the drive persists after reboot
cmd.exe /C "cmdkey /add:`"$StorageName.file.core.windows.net`" /user:`"localhost\$StorageName`" /pass:`"$StorageKey`""

# Step 2: Map the file share as drive Z:
New-PSDrive -Name "Z" `
    -PSProvider FileSystem `
    -Root "\\$StorageName.file.core.windows.net\myshare" `
    -Credential $Creds `
    -Persist

# ============================================================================
# REMOVE MAPPED DRIVE
# ============================================================================

# Remove the mapped drive when no longer needed
Remove-PSDrive -Name "Z"

# ============================================================================
# DELETE FILE SHARE
# ============================================================================

# Delete the file share from the storage account
az storage share delete `
    --account-name $StorageName `
    --account-key $StorageKey `
    --name "myshare"
