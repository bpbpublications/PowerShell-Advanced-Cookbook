# Import certificate to root store and establish and enter certificate based session
Import-Certificate -FilePath C:\Temp\ps-host01.cer `
-CertStoreLocation Cert:\LocalMachine\Root

$Session = New-PSSession -ComputerName PS-HOST01 -UseSSL

Enter-PSSession $Session