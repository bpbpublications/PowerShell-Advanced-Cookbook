

# On HOST: 
# 1. Create a self-signed certificate. DNS name must be HOSTNAME of REMOTE HOST
$Dns = "ps-host01"
$Cert = New-SelfSignedCertificate -DnsName $Dns `
-CertStoreLocation Cert:\LocalMachine\My

# 2. Export the public key of the certificate
$Cert | Export-Certificate -FilePath C:\Temp\ps-host01.cer

# 2.1. Export the certificate with the private key
$Cert | Export-PfxCertificate -FilePath C:\Temp\ps-host01.pfx `
-Password (ConvertTo-SecureString "CertPass" -AsPlainText -Force)

# 3. Enable PSRemoting with certificate based auth:
Set-Item WSMan:\localhost\Service\Auth\Certificate -Value $true

# 3.1. Check if certificate-based auth is enabled
winrm get winrm/config

# 4. Create new HTTPS WinRM listener
New-Item -Path WSMan:\localhost\listener -Transport HTTPS `
-Address * `
-CertificateThumbPrint $Cert.Thumbprint `
-HostName ps-host01 `
-Force

# 4.1. View all Listeners
Get-ChildItem WSMan:\localhost\Listener\

# 4.2. Remove HTTP listener
winrm delete winrm/config/listener?Address=*+Transport=HTTP

# 5. Create Firewall rule for WinRM port 5986
$Rule = "Windows Remote Management (HTTPS-In)"
New-NetFirewallRule -DisplayName $Rule `
-Name $Rule `
-Group $Rule `
-Profile Any `
-LocalPort 5986 `
-Protocol TCP

#  On CLIENT:
# 1. Copy public key of certificate from HOST to Client and import it into TRUSTED ROOT CERTIFICATE AUTHORITIES store (LocalMachine)
Import-Certificate -FilePath C:\Temp\ps-host01.cer `
-CertStoreLocation Cert:\LocalMachine\Root

# 2. Create new session Remember to use -useSSL parameter.
$Session = New-PSSession -ComputerName PS-HOST01 -UseSSL