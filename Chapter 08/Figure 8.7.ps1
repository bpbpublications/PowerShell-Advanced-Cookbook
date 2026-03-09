# Figure 8.7 - Modifying XML Values and Saving Changes
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates how to modify XML element values and persist changes to file.

# ============================================================================
# CREATE AND SAVE XML CONFIGURATION
# ============================================================================

[xml]$XmlObject = @"
<?xml version="1.0" encoding="UTF-8"?>
<Config>
    <Database id="database">
        <Instance>DBServer</Instance>
        <Port>1433</Port>
        <Database>TestDB</Database>
    </Database>
    <Azure id="azure">
        <SubscriptionID>9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e</SubscriptionID>
        <TenantID>1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7</TenantID>
        <ClientID>a8d2c4b6-1f7e-4e6a-b2d9-8c3a9d5e1f4c</ClientID>
        <ClientSecret>5e2d4b3a-7c8d-9b2a-6e4f-7a1f6c3b2d8a</ClientSecret>
    </Azure>
    <ServiceAccount id="serviceaccount">
        <UserName>Service.DBUser</UserName>
        <Password>ThisIsARandomPwd</Password>
    </ServiceAccount>
</Config>
"@

# Save to XML file
$XmlObject.Save("C:\Temp\Config3.xml")

# Read from file and assign to variable
$Config = Get-Content C:\Temp\Config3.xml

# ============================================================================
# VIEW CURRENT VALUE
# ============================================================================

# Display the current password value
Write-Output "Old Password: $($Config.Config.ServiceAccount.Password)"

# ============================================================================
# MODIFY XML VALUE IN MEMORY
# ============================================================================

# Update the password value in the XML object (in memory only)
$Config.Config.ServiceAccount.Password = "ThisIsANewPassword"

# Verify the change in memory
Write-Output "New Password: $($Config.Config.ServiceAccount.Password)"

# ============================================================================
# PERSIST CHANGES TO FILE
# ============================================================================

# Save the modified XML back to the file
# Note: The Save() method properly formats the XML output
$Config.Save("C:\Temp\Config3.xml")

# Verify the file was updated
Write-Output "`nUpdated file content:"
Get-Content "C:\Temp\Config3.xml"

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Old Password: ThisIsARandomPwd
# New Password: ThisIsANewPassword
#
# Updated file content:
# <?xml version="1.0" encoding="UTF-8"?>
# <Config>
#   ...
#   <ServiceAccount id="serviceaccount">
#     <UserName>Service.DBUser</UserName>
#     <Password>ThisIsANewPassword</Password>
#   </ServiceAccount>
# </Config>
