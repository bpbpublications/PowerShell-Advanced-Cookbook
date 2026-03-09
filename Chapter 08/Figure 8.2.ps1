# Figure 8.2 - XML Type Accelerator
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates using the [xml] type accelerator to create XmlDocument objects.

# ============================================================================
# XML TYPE ACCELERATOR
# ============================================================================

# The [xml] type accelerator converts string content to System.Xml.XmlDocument
# This enables XML-specific methods and properties for navigation and manipulation
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

# ============================================================================
# EXAMINE THE XML DOCUMENT TYPE
# ============================================================================

# Get-Member now reveals this is an XmlDocument with XML-specific capabilities
$XmlObject | Get-Member

# ============================================================================
# SAVING XML DOCUMENTS
# ============================================================================

# The XmlDocument.Save() method properly formats and saves XML
# This is the recommended way to write XML files
# $XmlObject.Save("C:\Temp\Config3.xml")

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Get-Member shows XmlDocument members:
#    TypeName: System.Xml.XmlDocument
#
# Name                 MemberType
# ----                 ----------
# AppendChild          Method
# CreateElement        Method
# GetElementsByTagName Method
# Load                 Method
# Save                 Method
# SelectNodes          Method
# SelectSingleNode     Method
# ...
# Config               Property     (auto-generated from root element)
#
# Note: PowerShell automatically creates properties for XML element names
