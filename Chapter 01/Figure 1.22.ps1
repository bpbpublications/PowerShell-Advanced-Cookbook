$Cert = (Get-ChildItem Cert:\CurrentUser\My\)[1]

$Cert | Remove-Item

Get-ChildItem Cert:\CurrentUser\My\