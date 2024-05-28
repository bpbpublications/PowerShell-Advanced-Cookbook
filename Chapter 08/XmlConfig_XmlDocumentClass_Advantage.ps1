# Create an XML document
$XmlDocument = New-Object System.Xml.XmlDocument

# Create the XML declaration
$XmlDeclaration = $XmlDocument.CreateXmlDeclaration("1.0", "UTF-8", $null)
$XmlDocument.AppendChild($XmlDeclaration)

# Create the root element
$Books = $XmlDocument.CreateElement("Books")
$XmlDocument.AppendChild($Books)

# Sample book data
$BooksData = @(
    @{ Title = "Book 1"; Author = "Author 1" },
    @{ Title = "Book 2"; Author = "Author 2" },
    @{ Title = "Book 3"; Author = "Author 3" }
)

# Create book elements using a loop
foreach ($BookInfo in $BooksData) {
    $Book = $XmlDocument.CreateElement("Book")
    $Books.AppendChild($Book)

    $Title = $XmlDocument.CreateElement("Title")
    $Title.InnerText = $BookInfo.Title
    $Book.AppendChild($Title)

    $Author = $XmlDocument.CreateElement("Author")
    $Author.InnerText = $BookInfo.Author
    $Book.AppendChild($Author)
}

# Save the XML document to a file
$XmlDocument.Save("books.xml")
