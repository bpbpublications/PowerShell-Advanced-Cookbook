$BooksTable = @{
    Publisher = @{
        Books = @(
            @{
                Id = 1
                Title = "Python for Developers"
                Author = "Mohit Raj"
                Technology = "Python"
                Year = 2019
                Isbn = "978-8194401872"
            }
            @{
                Id = 2
                Title = "PowerShell Advanced Cookbook"
                Author = "Morten E. Hansen"
                Technology = "PowerShell"
                Year = 2023
                Isbn = "978-XXXXXXXXXX"
            }
        )        
    }
}

# Export Hashtable and save to file as CliXml format
$BooksTable | Export-Clixml C:\Temp\Books.xml

# The CliXml data structure can be seen in the output file: C:\Temp\Books.xml