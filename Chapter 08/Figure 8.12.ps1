# Figure 8.12 - XPath Attribute Selection
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates selecting elements that have specific attributes using XPath.

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

# ============================================================================
# SELECT NODES WITH SPECIFIC ATTRIBUTE
# ============================================================================

# Find all elements that have an "id" attribute (regardless of value)
# //*[@id] means: any element, at any depth, that has an "id" attribute
Select-Xml -Path C:\Temp\Config3.xml -XPath "//*[@id]"

# ============================================================================
# XPATH ATTRIBUTE EXPRESSION EXPLAINED
# ============================================================================

# //       - Search at any depth in the document
# *        - Match any element name
# [@id]    - Filter: only elements that have an "id" attribute
# //*[@id] - Combined: any element anywhere with an "id" attribute

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Node           Path          Pattern
# ----           ----          -------
# Database       InputStream   //*[@id]
# Azure          InputStream   //*[@id]
# ServiceAccount InputStream   //*[@id]
#
# All three section elements have "id" attributes, so all three are returned
