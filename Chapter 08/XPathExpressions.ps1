# Recipe: XPath Expressions Reference
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Comprehensive reference for XPath expressions used with Select-Xml.

# ============================================================================
# XPATH EXPRESSION SYNTAX REFERENCE
# ============================================================================

# List all nodes in the XML document
"//node()"

# List all nodes excluding whitespace (spaces, tabs, linebreaks)
"//node()[normalize-space()]"

# Select the root node in the XML document
"/*"

# Select all elements with a specific name regardless of location
"//ElementName"

# Select parent element and its child elements
"//ParentElement/ChildElement"

# Select elements in a specific path
"/RootElement/Element1/Element2"

# Select elements with a specific attribute (check presence)
"//Element[@AttributeName]"

# Select elements with specific attribute name and value
"//Element[@AttributeName='Value']"

# ============================================================================
# USING SELECT-XML WITH XPATH
# ============================================================================

# Basic syntax
# Select-Xml -Path <PathToXMLDocument> -XPath <XPathExpression>

# Example: Select root node
Select-Xml -Path C:\Temp\Config3.xml -XPath "//Config"

# Example: List nodes without whitespace
Select-Xml -Path C:\Temp\Config3.xml -XPath "//node()[normalize-space()]"

# ============================================================================
# ACCESSING XPATH RESULTS
# ============================================================================

# Select root and view parent elements
$Root = Select-Xml -Path C:\Temp\Config3.xml -XPath "/*"
$Root.Node

# Select specific element by path
$AzureNode = Select-Xml -Path C:\Temp\Config3.xml -XPath "/Config/Azure"
$AzureNode.Node

# ============================================================================
# ATTRIBUTE-BASED SELECTION
# ============================================================================

# Check presence of an attribute
$SearchAttributePresence = Select-Xml -Path C:\Temp\Config3.xml -XPath "//*[@id]"
$SearchAttributePresence | ForEach-Object {
    "$($_.Node.Name) : $($_.Node.id)"
}

# Find elements with specific attribute values
$Att = Select-Xml -Path C:\Temp\Config3.xml -XPath "//*[@id='serviceaccount']"
$Att.Node

# ============================================================================
# COMMON XPATH PATTERNS
# ============================================================================

# //element           - Find element anywhere in document
# /root/child         - Absolute path from root
# //parent/child      - Find parent/child anywhere
# //*[@attr]          - Any element with attribute
# //*[@attr='value']  - Any element with attribute value
# //element[1]        - First element (1-based index)
# //element[last()]   - Last element
# //element[position()>1] - All but first element
# //element/text()    - Text content of element
