# Create a self-signed code signing certificate
$Dns = "CodeSigning"

$Certificate = New-SelfSignedCertificate -KeyUsage DigitalSignature -KeySpec Signature -KeyAlgorithm RSA -KeyLength 4096 -CertStoreLocation Cert:\CurrentUser\My -Type CodeSigningCert -Subject $Dns -DNSName $Dns -FriendlyName $Dns


# For multiple certificates, select a specific certificate
$CodeSign = (Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert)[0]
$CodeSign

# Script must be saved to a path (C:\Temp)
# # I need to sign this script!

# Write-Output "I need to sign this script!"
#Set-AuthenticodeSignature -FilePath <PathToScript> -Certificate $CodeSign