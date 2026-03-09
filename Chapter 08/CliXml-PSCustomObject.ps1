# Recipe: Export-Clixml with PSCustomObject
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates exporting and importing PSCustomObject using CliXml format.

# ============================================================================
# CREATE PSCUSTOMOBJECT STRUCTURE
# ============================================================================

# PSCustomObject provides a cleaner syntax for structured data
# Note the [PSCustomObject] cast at the beginning
$BooksObject = [PSCustomObject]@{
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

# Export the PSCustomObject to CliXml format
$BooksObject | Export-Clixml C:\Temp\BooksObject.xml

# ============================================================================
# IMPORT FROM CLIXML
# ============================================================================

# Import restores the PSCustomObject type
$NewObject = Import-Clixml C:\Temp\BooksObject.xml

# ============================================================================
# VERIFY TYPE PRESERVATION
# ============================================================================

# Check the type - should be PSCustomObject
$NewObject.GetType().Name  # Returns: PSCustomObject

# Access properties using dot notation
$NewObject.Publisher.Books

# ============================================================================
# PSCUSTOMOBJECT VS HASHTABLE FOR CLIXML
# ============================================================================

# PSCustomObject:
# - Properties accessed via dot notation
# - Better for read-only data structures
# - More PowerShell-idiomatic output formatting
#
# Hashtable:
# - Can add/remove keys dynamically
# - Better for lookup tables
# - Supports case-sensitive/insensitive options
