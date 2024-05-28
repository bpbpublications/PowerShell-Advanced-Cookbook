# # Create an XML object
# $xmlDocument = New-Object System.Xml.XmlDocument

# # Create root element
# $root = $xmlDocument.CreateElement("library")
# $xmlDocument.AppendChild($root)

# # Create book elements
# $book1 = $xmlDocument.CreateElement("book")
# $root.AppendChild($book1)

# $title1 = $xmlDocument.CreateElement("title")
# $title1.InnerText = "Book 1"
# $book1.AppendChild($title1)

# # Save the XML document to a file
# $xmlDocument.Save("output.xml")


# Create an XML object
$xmlDocument = New-Object System.Xml.XmlDocument

# Create the XML declaration
$declaration = $xmlDocument.CreateXmlDeclaration("1.0", "UTF-8", $null)
$xmlDocument.AppendChild($declaration)

# Create the root element
$publisher = $xmlDocument.CreateElement("publisher")
$xmlDocument.AppendChild($publisher)

# Create the first book element
$book1 = $xmlDocument.CreateElement("book")
$book1.SetAttribute("id", "1")

# Create sub-elements for the first book
$title1 = $xmlDocument.CreateElement("title")
$title1Lang = $xmlDocument.CreateAttribute("lang")
$title1Lang.Value = "en"
$title1.InnerText = "Python for Developers"
$title1.Attributes.Append($title1Lang)

$author1 = $xmlDocument.CreateElement("author")
$author1.InnerText = "Mohit Raj"

$technology1 = $xmlDocument.CreateElement("technology")
$technology1.InnerText = "Python"

$year1 = $xmlDocument.CreateElement("year")
$year1.InnerText = "2019"

$isbn1 = $xmlDocument.CreateElement("isbn")
$isbn1.SetAttribute("format", "paperback")
$isbn1.InnerText = "978-8194401872"

# Append sub-elements to the first book element
$book1.AppendChild($title1)
$book1.AppendChild($author1)
$book1.AppendChild($technology1)
$book1.AppendChild($year1)
$book1.AppendChild($isbn1)

# Create the second book element (similar to the first)
$book2 = $xmlDocument.CreateElement("book")
$book2.SetAttribute("id", "2")

# Create sub-elements for the second book
$title2 = $xmlDocument.CreateElement("title")
$title2Lang = $xmlDocument.CreateAttribute("lang")
$title2Lang.Value = "en"
$title2.InnerText = "PowerShell Advanced Cookbook"
$title2.Attributes.Append($title2Lang)

$author2 = $xmlDocument.CreateElement("author")
$author2.InnerText = "Morten E. Hansen"

$technology2 = $xmlDocument.CreateElement("technology")
$technology2.InnerText = "PowerShell"

$year2 = $xmlDocument.CreateElement("year")
$year2.InnerText = "2023"

$isbn2 = $xmlDocument.CreateElement("isbn")
$isbn2.SetAttribute("format", "paperback")
$isbn2.InnerText = "978-XXXXXXXXXX"

# Append sub-elements to the second book element
$book2.AppendChild($title2)
$book2.AppendChild($author2)
$book2.AppendChild($technology2)
$book2.AppendChild($year2)
$book2.AppendChild($isbn2)

# Append book elements to the publisher
$publisher.AppendChild($book1)
$publisher.AppendChild($book2)

# Save the XML document to a file
$xmlDocument.Save("example.xml")
