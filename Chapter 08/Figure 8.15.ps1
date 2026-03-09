# Figure 8.15 - Export-Clixml with Hashtables
# Chapter 8: Working with XML and JSON
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates exporting PowerShell hashtables to CliXml format.

# ============================================================================
# CREATE NESTED HASHTABLE STRUCTURE
# ============================================================================

# Define a complex nested hashtable with books data
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
# EXPORT TO CLIXML FORMAT
# ============================================================================

# Export-Clixml serializes the entire object structure to XML
# This preserves types, nested structures, and can be restored later
$BooksTable | Export-Clixml C:\Temp\Books.xml

# View the resulting file to see the CliXml data structure
# Get-Content C:\Temp\Books.xml

# ============================================================================
# CLIXML BENEFITS
# ============================================================================

# - Preserves PowerShell object types (hashtables stay as hashtables)
# - Handles nested structures automatically
# - Can serialize complex objects including credentials (with encryption)
# - Restored objects retain original structure and types

# ============================================================================
# EXPECTED OUTPUT FILE STRUCTURE
# ============================================================================

# The CliXml file contains serialized object data with type information:
# <Objs Version="1.1.0.1" xmlns="...">
#   <Obj RefId="0">
#     <TN RefId="0">
#       <T>System.Collections.Hashtable</T>
#       ...
#     </TN>
#     <DCT>
#       <En>
#         <S N="Key">Publisher</S>
#         <Obj N="Value" RefId="1">...
