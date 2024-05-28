# Time measure: Get-ADUser with Filter parameter
(Measure-Command {
    foreach ($i in 0..10000){
        Get-ADUser -Filter "Country -eq 'DK'"
    }
}).TotalMilliseconds

# Time measure: Get-ADUser with Where-Object filtering
(Measure-Command {
    foreach ($i in 0..10000){
        Get-ADUser -Filter * | Where-Object {$_.Country -eq "DK"}
    }
}).TotalMilliseconds
