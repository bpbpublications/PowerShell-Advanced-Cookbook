# Figure 10.21 - Verify Entra ID Group Members
# Chapter 10: Azure CLI with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Shows the complete user/group creation with verification.

# ============================================================================
# CREATE RESOURCE GROUP
# ============================================================================

$RG = az group create `
    --name "RG-App01" `
    --location "westeurope" | `
    ConvertFrom-Json

# ============================================================================
# CREATE ENTRA ID GROUP
# ============================================================================

$AdGroup = az ad group create `
    --display-name "AccessTo-RG-App01" `
    --mail-nickname "AccessTo-RG-App01" | `
    ConvertFrom-Json

# ============================================================================
# CREATE USERS AND ADD TO GROUP
# ============================================================================

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

foreach ($User in $Users) {
    $ADUser = az ad user create `
        --display-name "$($User.name)" `
        --user-principal-name "$($User.upn)" `
        --password "$($User.password)" | `
        ConvertFrom-Json

    az ad group member add `
        --group "$($AdGroup.id)" `
        --member-id "$($ADUser.id)"
}

# ============================================================================
# ASSIGN RBAC ROLE
# ============================================================================

az role assignment create `
    --assignee "$($AdGroup.id)" `
    --role "Contributor" `
    --scope "$($RG.id)"

# ============================================================================
# VERIFY GROUP MEMBERS
# ============================================================================

# List group members to verify users were created and added
az ad group member list --group "$($AdGroup.displayName)"
