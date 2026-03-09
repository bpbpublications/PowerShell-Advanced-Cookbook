# Recipe: Entra ID User and Group Management
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating Entra ID users, groups, and RBAC assignments.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Create a resource group that users will have access to
$RG = az group create `
    --name "RG-App01" `
    --location "westeurope" | `
    ConvertFrom-Json

# ============================================================================
# CREATE ENTRA ID (AZURE AD) GROUP
# ============================================================================

# Create a security group for managing access
$AdGroup = az ad group create `
    --display-name "AccessTo-RG-App01" `
    --mail-nickname "AccessTo-RG-App01" | `
    ConvertFrom-Json

# ============================================================================
# DEFINE USERS TO CREATE
# ============================================================================

# User data - could come from CSV, API, or other data source
$Users = @(
    @{
        name     = "Liam Anderson"
        upn      = "Lian@bio-rent.dk"
        password = "@Test123456789"
    }
    @{
        name     = "Mia Garcia"
        upn      = "Miga@bio-rent.dk"
        password = "@Test123456789"
    }
    @{
        name     = "Oliver Patel"
        upn      = "Olpa@bio-rent.dk"
        password = "@Test123456789"
    }
)

# ============================================================================
# CREATE USERS AND ADD TO GROUP
# ============================================================================

foreach ($User in $Users) {
    # Create Entra ID user
    $ADUser = az ad user create `
        --display-name "$($User.name)" `
        --user-principal-name "$($User.upn)" `
        --password "$($User.password)" | `
        ConvertFrom-Json

    # Add user to the Entra ID group
    az ad group member add `
        --group "$($AdGroup.id)" `
        --member-id "$($ADUser.id)"
}

# ============================================================================
# ASSIGN RBAC ROLE TO GROUP
# ============================================================================

# Assign Contributor role at resource group scope
# All group members inherit this permission
az role assignment create `
    --assignee "$($AdGroup.id)" `
    --role "Contributor" `
    --scope "$($RG.id)"
