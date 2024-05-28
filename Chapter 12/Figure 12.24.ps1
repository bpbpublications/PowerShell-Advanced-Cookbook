# Requires connection to Microsoft Graph (SDK Module)

# Connect interactively with user and directory read/write permissions
Connect-MgGraph -Scopes "User.ReadWrite.All", "Directory.ReadWrite.All"

# Connect using certificate based app-only access
$CertificateThumbprint ="<Certificate Thumbprint>"
$ApplicationId= "<Application (Client) ID>"
$TenantId ="<Tenant ID>"

Connect-MgGraph `
-TenantId $TenantID `
-ClientId $ApplicationID `
-CertificateThumbprint $CertificateThumbprint

Get-MgUser -UserId john@bio-rent.dk