# XPath expressions

# List all nodes in the XML document
"//node()"

# List all node in the XML document
# Excluding whitespace nodes (spaces, tabs and linebreaks)
"//node()[normalize-space()]"

# Select the Root node in the XML document
"//*"

# Select all elements with a specific name 
# regardles of their location in the XML document:
"//ElementName"

# Select Parent element and its child elements
"//ParentElement/ChildElement"

# Select all elements in a specific path
"//RootElement/Element1/Element2"

# Select elements with a specific attribute
# regardless of its value. (Check presence of an attribute)
"//Element[@AttributeName]"

# Select elements with a specific attribute name and value
# Find elements with "Id=database"
"//Element[@AttributeName='Value']"


# Select-Xml using XPath expression
Select-Xml -Path <PathToXMLDocument> -XPath <XPathExpression>

# Example
Select-Xml -Path C:\Temp\Config3.xml -XPath "//Config"

# Example: List and view nodes (without whitespace)
Select-Xml -Path C:\Temp\Config3.xml -XPath "//node()[normalize-space()]"

# Example: View parent elements within the root node
$Root = Select-Xml -Path C:\Temp\Config3.xml -XPath "//*"
$Root.Node

# Example: Select content of specific Element

$AzureNode = Select-Xml -Path C:\Temp\Config3.xml -XPath "/Config/Azure"
$AzureNode.Node

# Example: Check presence of an attribute
$SearchAttributePresence = Select-Xml -Path C:\Temp\Config3.xml -XPath "//*[@id]"
$SearchAttributePresence | ForEach-Object {
    "$($_.Node.Name) : $($_.Node.id)"
}

# Example: Find elements with specific attribtue values
$Att = Select-Xml -Path C:\Temp\Config3.xml -XPath "//*[@id='serviceaccount']"
$Att.Node