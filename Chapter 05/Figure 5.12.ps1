# Create a self-signed code signing certificate
$Dns = "CodeSigning"

$Certificate = New-SelfSignedCertificate -KeyUsage DigitalSignature -KeySpec Signature -KeyAlgorithm RSA -KeyLength 4096 -CertStoreLocation Cert:\CurrentUser\My -Type CodeSigningCert -Subject $Dns -DNSName $Dns -FriendlyName $Dns


# View currently installed code signing certificates (CurrentUser)
Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert
