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
$Success = $false
while ($Attempts -lt 3){
    $UserPassword = Read-Host -Prompt "Enter password"
    if ($UserPassword -in $PasswordDatabase){
        $Success = $true
        break
    }
    else{
        Write-Output "Wrong password. Retry."
        $Attempts ++
    }
}
if ($Success){
    Write-Output "Password accepted. Access granted."
}
else{
    Write-Output "Too many attempts. Access denied"
}


