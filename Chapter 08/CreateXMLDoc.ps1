# Recipe: Creating XML Documents Programmatically
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates building complex XML documents using System.Xml.XmlDocument class.

# ============================================================================
# CREATE XML DOCUMENT INSTANCE
# ============================================================================

# Create a new XML document object
$xmlDocument = New-Object System.Xml.XmlDocument

# Create and append the XML declaration (<?xml version="1.0"...?>)
$declaration = $xmlDocument.CreateXmlDeclaration("1.0", "UTF-8", $null)
$xmlDocument.AppendChild($declaration)

# ============================================================================
# CREATE ROOT ELEMENT
# ============================================================================

# Create the root <publisher> element
$publisher = $xmlDocument.CreateElement("publisher")
$xmlDocument.AppendChild($publisher)

# ============================================================================
# CREATE FIRST BOOK ELEMENT
# ============================================================================

# Create <book> element with id attribute
$book1 = $xmlDocument.CreateElement("book")
$book1.SetAttribute("id", "1")

# Create <title> element with language attribute
$title1 = $xmlDocument.CreateElement("title")
$title1Lang = $xmlDocument.CreateAttribute("lang")
$title1Lang.Value = "en"
$title1.InnerText = "Python for Developers"
$title1.Attributes.Append($title1Lang)

# Create other sub-elements for first book
$author1 = $xmlDocument.CreateElement("author")
$author1.InnerText = "Mohit Raj"

$technology1 = $xmlDocument.CreateElement("technology")
$technology1.InnerText = "Python"

$year1 = $xmlDocument.CreateElement("year")
$year1.InnerText = "2019"

$isbn1 = $xmlDocument.CreateElement("isbn")
$isbn1.SetAttribute("format", "paperback")
$isbn1.InnerText = "978-8194401872"

# Append all sub-elements to first book
$book1.AppendChild($title1)
$book1.AppendChild($author1)
$book1.AppendChild($technology1)
$book1.AppendChild($year1)
$book1.AppendChild($isbn1)

# ============================================================================
# CREATE SECOND BOOK ELEMENT
# ============================================================================

# Create <book> element with id attribute
$book2 = $xmlDocument.CreateElement("book")
$book2.SetAttribute("id", "2")

# Create <title> element with language attribute
$title2 = $xmlDocument.CreateElement("title")
$title2Lang = $xmlDocument.CreateAttribute("lang")
$title2Lang.Value = "en"
$title2.InnerText = "PowerShell Advanced Cookbook"
$title2.Attributes.Append($title2Lang)

# Create other sub-elements for second book
$author2 = $xmlDocument.CreateElement("author")
$author2.InnerText = "Morten E. Hansen"

$technology2 = $xmlDocument.CreateElement("technology")
$technology2.InnerText = "PowerShell"

$year2 = $xmlDocument.CreateElement("year")
$year2.InnerText = "2023"

$isbn2 = $xmlDocument.CreateElement("isbn")
$isbn2.SetAttribute("format", "paperback")
$isbn2.InnerText = "978-XXXXXXXXXX"

# Append all sub-elements to second book
$book2.AppendChild($title2)
$book2.AppendChild($author2)
$book2.AppendChild($technology2)
$book2.AppendChild($year2)
$book2.AppendChild($isbn2)

# ============================================================================
# APPEND BOOKS TO PUBLISHER
# ============================================================================

$publisher.AppendChild($book1)
$publisher.AppendChild($book2)

# ============================================================================
# SAVE XML DOCUMENT
# ============================================================================

# Save the XML document to a file
$xmlDocument.Save("example.xml")

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# <?xml version="1.0" encoding="UTF-8"?>
# <publisher>
#   <book id="1">
#     <title lang="en">Python for Developers</title>
#     <author>Mohit Raj</author>
#     <technology>Python</technology>
#     <year>2019</year>
#     <isbn format="paperback">978-8194401872</isbn>
#   </book>
#   <book id="2">
#     <title lang="en">PowerShell Advanced Cookbook</title>
#     <author>Morten E. Hansen</author>
#     <technology>PowerShell</technology>
#     <year>2023</year>
#     <isbn format="paperback">978-XXXXXXXXXX</isbn>
#   </book>
# </publisher>
