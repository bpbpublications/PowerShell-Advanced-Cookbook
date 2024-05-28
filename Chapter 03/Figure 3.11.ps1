$PasswordDatabase = @(
    "Passw0rd!",
    "S3cur3P@ss",
    "P@ssw0rd123",
    "MyP@ssw0rd",
    "SuperSecret!",
    "12345Password",
    "P@55word!",
    "Secret123$",
    "P@ssw0rd!",
    "P@ssword2023"
)

$Attempts = 0
$Success = $null
do{
    if ($Attempts -lt 3){
        $UserPassword = Read-Host -Prompt "Enter password"
    }
    else{
        Write-Output "To many attempts. Access denied"
        $Success = $false
        break
    }
    $Attempts ++
    
}while($UserPassword -notin $PasswordDatabase)

if ($Success -ne $false){
    Write-Output "Password accepted. Access granted."
}