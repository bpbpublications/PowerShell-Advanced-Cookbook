# Figure 8.1 - XML as Plain Text String
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates that XML stored as a plain string has no XML-specific properties.

# ============================================================================
# XML AS PLAIN TEXT (STRING TYPE)
# ============================================================================

# Define XML content using a here-string
# When stored as a plain string, PowerShell treats it as text, not XML
$XmlText = @"
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

# ============================================================================
# EXAMINE THE STRING TYPE
# ============================================================================

# Get-Member reveals this is just a System.String, not an XML object
# No XML-specific methods like SelectNodes, Save, etc. are available
$XmlText | Get-Member

# ============================================================================
# WRITING STRING TO FILE (NOT RECOMMENDED FOR XML)
# ============================================================================

# These methods write the text but don't validate or format XML
# $XmlText | Out-File C:\Temp\Config1.xml
# $XmlText | Set-Content C:\Temp\Config2.xml

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Get-Member shows string methods only:
#    TypeName: System.String
#
# Name             MemberType
# ----             ----------
# Clone            Method
# Contains         Method
# EndsWith         Method
# ...
#
# Note: No XML-specific methods like SelectSingleNode, Save, Load, etc.
# To work with XML properly, use the [xml] type accelerator (see Figure 8.2)
