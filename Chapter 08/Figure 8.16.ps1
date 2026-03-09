# Figure 8.16 - Import-Clixml and Data Filtering
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates importing CliXml and filtering restored data with Where-Object.

# ============================================================================
# CREATE AND EXPORT SAMPLE DATA
# ============================================================================

# First, create the hashtable structure
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

# Export to CliXml format
$BooksTable | Export-Clixml C:\Temp\Books.xml

# ============================================================================
# IMPORT AND RESTORE OBJECT
# ============================================================================

# In a new PowerShell session (or the same), load the CliXml file
# Import-Clixml deserializes and restores the original object structure
$NewBooksTable = Import-Clixml C:\Temp\Books.xml

# View the restored hashtable
$NewBooksTable

# ============================================================================
# FILTER DATA WITH WHERE-OBJECT
# ============================================================================

# Filter by Id property
$NewBooksTable.Publisher.Books | Where-Object { $_.Id -eq 1 }

# Filter by Author property
$NewBooksTable.Publisher.Books | Where-Object { $_.Author -eq "Morten E. Hansen" }

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Filter by Id=1:
# Name                           Value
# ----                           -----
# Id                             1
# Title                          Python for Developers
# Author                         Mohit Raj
# Technology                     Python
# Year                           2019
# Isbn                           978-8194401872
#
# Filter by Author="Morten E. Hansen":
# Name                           Value
# ----                           -----
# Id                             2
# Title                          PowerShell Advanced Cookbook
# Author                         Morten E. Hansen
# Technology                     PowerShell
# Year                           2023
# Isbn                           978-XXXXXXXXXX
