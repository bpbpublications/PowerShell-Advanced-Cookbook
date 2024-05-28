$Name = "TestCert-CurrentUser"
New-SelfSignedCertificate -Subject $Name -DnsName "CN=$Name" -FriendlyName $Name -CertStoreLocation Cert:\CurrentUser\my