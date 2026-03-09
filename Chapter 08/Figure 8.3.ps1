# Figure 8.3 - Creating XML with XmlDocument Class
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates programmatic XML creation using System.Xml.XmlDocument.

# ============================================================================
# CREATE XML DOCUMENT PROGRAMMATICALLY
# ============================================================================

# Create a new XML document instance
$XmlDocument = New-Object System.Xml.XmlDocument

# Create and append the XML declaration (<?xml version="1.0"...?>)
$XmlDeclaration = $XmlDocument.CreateXmlDeclaration("1.0", "UTF-8", $null)
$XmlDocument.AppendChild($XmlDeclaration)

# Create the root element <Config>
$Config = $XmlDocument.CreateElement("Config")
$XmlDocument.AppendChild($Config)

# ============================================================================
# CREATE DATABASE SECTION
# ============================================================================

# Create Database element with Id attribute
$Database = $XmlDocument.CreateElement("Database")
$Database.SetAttribute("Id", "database")
$Config.AppendChild($Database)

# Add child elements to the Database section
$Instance = $XmlDocument.CreateElement("Instance")
$Instance.InnerText = "DBServer"
$Database.AppendChild($Instance)

$Port = $XmlDocument.CreateElement("Port")
$Port.InnerText = "1433"
$Database.AppendChild($Port)

$DatabaseName = $XmlDocument.CreateElement("Database")
$DatabaseName.InnerText = "TestDB"
$Database.AppendChild($DatabaseName)

# ============================================================================
# CREATE AZURE SECTION
# ============================================================================

# Create Azure element with Id attribute
$Azure = $XmlDocument.CreateElement("Azure")
$Azure.SetAttribute("Id", "azure")
$Config.AppendChild($Azure)

# Add child elements to the Azure section
$SubscriptionId = $XmlDocument.CreateElement("SubscriptionId")
$SubscriptionId.InnerText = "9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e"
$Azure.AppendChild($SubscriptionId)

$TenantId = $XmlDocument.CreateElement("TenantId")
$TenantId.InnerText = "1e9d4a5f-9b2a-6e7b-3a7d-2c4d60b7ca7"
$Azure.AppendChild($TenantId)

$ClientId = $XmlDocument.CreateElement("ClientId")
$ClientId.InnerText = "a8d2c4b6-1f7e-4e6a-b2d9-8c3a9d5e1f4c"
$Azure.AppendChild($ClientId)

$ClientSecret = $XmlDocument.CreateElement("ClientSecret")
$ClientSecret.InnerText = "5e2d4b3a-7c8d-9b2a-6e4f-7a1f6c3b2d8a"
$Azure.AppendChild($ClientSecret)

# ============================================================================
# CREATE SERVICE ACCOUNT SECTION
# ============================================================================

# Create ServiceAccount element with Id attribute
$ServiceAccount = $XmlDocument.CreateElement("ServiceAccount")
$ServiceAccount.SetAttribute("Id", "serviceaccount")
$Config.AppendChild($ServiceAccount)

# Add child elements to the ServiceAccount section
$UserName = $XmlDocument.CreateElement("UserName")
$UserName.InnerText = "Service.DBUser"
$ServiceAccount.AppendChild($UserName)

$Password = $XmlDocument.CreateElement("Password")
$Password.InnerText = "ThisIsARandomPwd"
$ServiceAccount.AppendChild($Password)

# ============================================================================
# SAVE AND VERIFY
# ============================================================================

# Save the XML document to a file
$XmlDocument.Save("C:\Temp\Config3.xml")

# View the saved content
Get-Content C:\Temp\Config3.xml

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# <?xml version="1.0" encoding="UTF-8"?>
# <Config>
#   <Database Id="database">
#     <Instance>DBServer</Instance>
#     <Port>1433</Port>
#     <Database>TestDB</Database>
#   </Database>
#   <Azure Id="azure">
#     <SubscriptionId>9c4b3e8a-2d1f-6a7b-5e9c-8d3a6f1c4b9e</SubscriptionId>
#     ...
#   </Azure>
#   <ServiceAccount Id="serviceaccount">
#     <UserName>Service.DBUser</UserName>
#     <Password>ThisIsARandomPwd</Password>
#   </ServiceAccount>
# </Config>
