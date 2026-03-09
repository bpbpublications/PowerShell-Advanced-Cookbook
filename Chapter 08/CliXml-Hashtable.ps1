# Recipe: Export-Clixml with Hashtables
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates exporting and importing hashtable structures using CliXml format.

# ============================================================================
# CREATE COMPLEX HASHTABLE STRUCTURE
# ============================================================================

# Define a nested hashtable containing book information
$BooksTable = @{
    Publisher = @{
        Books = @(
            @{
                Id         = 1
                Title      = "Python for Developers"
                Author     = "Mohit Raj"
                Technology = "Python"
                Year       = 2019
                Isbn       = "978-8194401872"
            }
            @{
                Id         = 2
                Title      = "PowerShell Advanced Cookbook"
                Author     = "Morten E. Hansen"
                Technology = "PowerShell"
                Year       = 2023
                Isbn       = "978-XXXXXXXXXX"
            }
        )
    }
}

# ============================================================================
# EXPORT TO CLIXML
# ============================================================================

# Export-Clixml serializes the entire hashtable structure
# The type information is preserved, allowing exact reconstruction
$BooksTable | Export-Clixml C:\Temp\Books.xml

# ============================================================================
# IMPORT FROM CLIXML
# ============================================================================

# In a new PowerShell session, import the serialized data
# Import-Clixml reconstructs the original hashtable structure
$NewBooksTable = Import-Clixml C:\Temp\Books.xml

# ============================================================================
# VERIFY RESTORED DATA
# ============================================================================

# The imported data retains its original type and structure
$NewBooksTable
$NewBooksTable.GetType().Name  # Returns: Hashtable

# Access nested data
$NewBooksTable.Publisher.Books

# ============================================================================
# USE CASES FOR CLIXML WITH HASHTABLES
# ============================================================================

# - Persisting configuration data between sessions
# - Saving state for long-running scripts
# - Sharing structured data between scripts
# - Creating backups of in-memory data structures
