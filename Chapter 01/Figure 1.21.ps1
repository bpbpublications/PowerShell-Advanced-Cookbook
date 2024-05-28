$Cert = (Get-ChildItem Cert:\CurrentUser\My\)[1]
$Cert | Select-Object *