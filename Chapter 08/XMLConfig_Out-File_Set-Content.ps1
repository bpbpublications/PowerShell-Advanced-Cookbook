# Recipe: Writing XML as Text (Not Recommended)
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates writing XML as plain text (for comparison with proper methods).

# ============================================================================
# XML AS PLAIN TEXT STRING
# ============================================================================

# This is XML content stored as a regular string
# No XML validation or parsing occurs
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
# WRITE TO FILE AS TEXT
# ============================================================================

# Out-File: Writes with default encoding, adds newline
$XmlText | Out-File C:\Temp\Config1.xml

# Set-Content: Similar but with different default encoding
$XmlText | Set-Content C:\Temp\Config2.xml

# ============================================================================
# WHY THIS APPROACH IS NOT RECOMMENDED
# ============================================================================

# - No XML validation: Malformed XML won't be detected
# - No formatting: Output matches input exactly (no pretty-print)
# - Encoding issues: May not match XML declaration encoding
# - No manipulation: Can't easily modify individual elements
#
# Recommended approach: Use [xml] accelerator + .Save() method
