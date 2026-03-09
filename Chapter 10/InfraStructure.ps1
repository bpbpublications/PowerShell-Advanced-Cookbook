# Recipe: Parameterized Infrastructure Provisioning Script
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates a reusable script for provisioning multiple VMs.

# ============================================================================
# SCRIPT PARAMETERS
# ============================================================================

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [String]$ResourceGroup = "RG-Infrastructure",

    [Parameter(Position = 1)]
    [String]$Location = "westeurope",

    [Parameter(Position = 2)]
    [String[]]$VMs = @("VmOne", "VmTwo", "VmThree"),

    [Parameter(Position = 3)]
    [String]$ConfigPath = ".\Infrastructure.config"
)

# ============================================================================
# LOAD CONFIGURATION
# ============================================================================

# Load service principal credentials from XML config file
[xml]$Config = Get-Content $ConfigPath

# ============================================================================
# LOGIN WITH SERVICE PRINCIPAL
# ============================================================================

# Login using credentials from config file
az login --service-principal `
    --username "$($Config.Azure.UserName)" `
    --password="$($Config.Azure.Password)" `
    --tenant "$($Config.Azure.TenantID)"

# ============================================================================
# PROVISION VIRTUAL MACHINES
# ============================================================================

# Create each VM in the list
foreach ($Vm in $VMs) {
    az vm create `
        --resource-group $ResourceGroup `
        --name $Vm `
        --image "Win2022Datacenter" `
        --size "Standard_B2s" `
        --admin-username "TestUser" `
        --admin-password "@Test123456789" `
        --location $Location
}

# ============================================================================
# LOGOUT
# ============================================================================

az logout

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Example: Provision to a different resource group with custom VMs
# .\Infrastructure.ps1 -ResourceGroup "RG-New" `
#     -Location "East Us" `
#     -VMs "TestVm", "DevVM", "StagingVM", "PocVM", "ProdVM" `
#     -ConfigPath "C:\Configs\RG-New.config"
