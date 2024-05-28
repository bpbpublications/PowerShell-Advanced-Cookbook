(Get-ChildItem Cert:\CurrentUser\My\)[1]

Get-Item -Path Cert:\CurrentUser\My\<CERTIFICATETHUMBPRINT>

Get-ChildItem Cert:\CurrentUser\My | Where-Object {$_.Subject -match "CN=<CERTCNNAME>"}

Get-ChildItem Cert:\CurrentUser\My | Where-Object {$_.FriendlyName -match "CN=<CERTFRIENDLYNAME>"}