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

# In a new PowerShell session. Load the C:\Temp\Books.xml file
$NewBooksTable = Import-Clixml C:\Temp\Books.xml

# View new loaded Hashtable 
$NewBooksTable

# Filter new loaded Hashtable for Book with Id=1
$NewBooksTable.Publisher.Books | Where-Object {$_.Id -eq 1}

# Filter new loaded Hashtable for Book with Author=Morten E. Hansen
$NewBooksTable.Publisher.Books | Where-Object {$_.Author -eq "Morten E. Hansen"}