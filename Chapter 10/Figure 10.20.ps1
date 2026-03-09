# Figure 10.20 - Create Entra ID Users and Assign RBAC Roles
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating Entra ID users, groups, and RBAC role assignments.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

# Create a resource group and capture the output
$RG = az group create `
    --name "RG-App01" `
    --location "westeurope" | `
    ConvertFrom-Json

# ============================================================================
# CREATE ENTRA ID GROUP
# ============================================================================

# Create an Entra ID (Azure AD) security group
$AdGroup = az ad group create `
    --display-name "AccessTo-RG-App01" `
    --mail-nickname "AccessTo-RG-App01" | `
    ConvertFrom-Json

# ============================================================================
# CREATE USERS AND ADD TO GROUP
# ============================================================================

# Define users to create
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

# Create each user and add to the group
foreach ($User in $Users) {
    # Create Entra ID user
    $ADUser = az ad user create `
        --display-name "$($User.name)" `
        --user-principal-name "$($User.upn)" `
        --password "$($User.password)" | `
        ConvertFrom-Json

    # Add user to Entra ID group
    az ad group member add `
        --group "$($AdGroup.id)" `
        --member-id "$($ADUser.id)"
}

# ============================================================================
# ASSIGN RBAC ROLE
# ============================================================================

# Assign Contributor role for the resource group to the Entra ID group
az role assignment create `
    --assignee "$($AdGroup.id)" `
    --role "Contributor" `
    --scope "$($RG.id)"

# ============================================================================
# VERIFY ROLE ASSIGNMENT
# ============================================================================

# List role assignments to verify
az role assignment list --scope "$($RG.id)"
