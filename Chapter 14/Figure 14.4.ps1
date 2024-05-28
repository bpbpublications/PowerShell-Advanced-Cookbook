# Listing a set of services using Where-Object and specific properties using Select-Object
Get-Service | `
Where-Object {$_.DisplayName.StartsWith("Windows")} | `
Select-Object Status,StartType,DisplayName