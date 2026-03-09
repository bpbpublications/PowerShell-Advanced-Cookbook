# Recipe: Dynamic XML Creation with Loops
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates the advantage of XmlDocument for dynamic XML generation.

# ============================================================================
# CREATE XML DOCUMENT
# ============================================================================

# Create XML document with declaration
$XmlDocument = New-Object System.Xml.XmlDocument
$XmlDeclaration = $XmlDocument.CreateXmlDeclaration("1.0", "UTF-8", $null)
$XmlDocument.AppendChild($XmlDeclaration)

# Create root element
$Books = $XmlDocument.CreateElement("Books")
$XmlDocument.AppendChild($Books)

# ============================================================================
# DEFINE DATA SOURCE
# ============================================================================

# Sample data that could come from a database, CSV, or API
$BooksData = @(
    @{ Title = "Book 1"; Author = "Author 1" },
    @{ Title = "Book 2"; Author = "Author 2" },
    @{ Title = "Book 3"; Author = "Author 3" }
)

# ============================================================================
# BUILD XML DYNAMICALLY WITH LOOP
# ============================================================================

# This is where XmlDocument shines - creating elements from data
foreach ($BookInfo in $BooksData) {
    # Create book element
    $Book = $XmlDocument.CreateElement("Book")
    $Books.AppendChild($Book)

    # Create and add title element
    $Title = $XmlDocument.CreateElement("Title")
    $Title.InnerText = $BookInfo.Title
    $Book.AppendChild($Title)

    # Create and add author element
    $Author = $XmlDocument.CreateElement("Author")
    $Author.InnerText = $BookInfo.Author
    $Book.AppendChild($Author)
}

# ============================================================================
# SAVE XML DOCUMENT
# ============================================================================

$XmlDocument.Save("books.xml")

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# <?xml version="1.0" encoding="UTF-8"?>
# <Books>
#   <Book>
#     <Title>Book 1</Title>
#     <Author>Author 1</Author>
#   </Book>
#   <Book>
#     <Title>Book 2</Title>
#     <Author>Author 2</Author>
#   </Book>
#   <Book>
#     <Title>Book 3</Title>
#     <Author>Author 3</Author>
#   </Book>
# </Books>

# ============================================================================
# ADVANTAGE OVER HERE-STRING APPROACH
# ============================================================================

# - Data-driven: Number of elements determined by data
# - Clean separation: Data definition separate from XML structure
# - Maintainable: Easy to add new fields or change structure
# - Testable: Can unit test XML generation logic
