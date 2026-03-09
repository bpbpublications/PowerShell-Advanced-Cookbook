# Figure 8.4 - XML Parsing Error Handling
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates XML parsing errors when XML is malformed (missing closing tag).

# ============================================================================
# MALFORMED XML EXAMPLE
# ============================================================================

# This XML is intentionally malformed - missing the closing </Config> tag
# When PowerShell tries to parse this, it will throw an error
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

"@
# Note: Missing </Config> closing tag above - THIS WILL CAUSE AN ERROR!

# ============================================================================
# READING MALFORMED XML FROM FILE
# ============================================================================

# If you save malformed XML to a file and try to read it:
# $XmlObject.Save("C:\Temp\Config3.xml")  # Would fail anyway
[xml]$Config = Get-Content C:\Temp\Config3.xml  # Should introduce error!

# ============================================================================
# EXPECTED ERROR
# ============================================================================

# Exception: Cannot convert value "..." to type "System.Xml.XmlDocument".
# Error: "Unexpected end of file has occurred. The following elements
# are not closed: Config. Line X, position Y."

# ============================================================================
# BEST PRACTICE: VALIDATE XML BEFORE PARSING
# ============================================================================

# Always use try/catch when parsing XML from external sources:
# try {
#     [xml]$Config = Get-Content C:\Temp\Config3.xml
# }
# catch {
#     Write-Error "Failed to parse XML: $_"
# }
