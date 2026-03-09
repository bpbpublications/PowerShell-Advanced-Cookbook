# Figure 12.17 - Distribution Group Members
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (ExchangeOnlineManagement module)
# Prerequisites: ExchangeOnlineManagement module, Exchange Admin rights

# ============================================================================
# CONNECT TO EXCHANGE ONLINE
# ============================================================================

# Connect to Exchange Online using credentials
$User = "Exchange@bio-rent.dk"
$Password = "ExcOnline@4321"

# Convert the password to a secure string
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force

# Create the PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential($User, $SecurePassword)

# Connect to Exchange Online
Connect-ExchangeOnline -Credential $Credentials

# ============================================================================
# LIST DISTRIBUTION GROUP MEMBERS
# ============================================================================

# List members of a distribution group
Get-DistributionGroupMember `
    -Identity "Employees" |
    Select-Object DisplayName, WindowsLiveId

# Expected Output:
# DisplayName      WindowsLiveId
# -----------      -------------
# John Ambrose     john@bio-rent.dk
# Jane Doe         jane@bio-rent.dk
# ...
#
# NOTE: Distribution groups are used for sending emails to multiple recipients
# Use Add-DistributionGroupMember to add members
