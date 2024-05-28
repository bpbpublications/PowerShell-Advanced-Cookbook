# Image of the Start-DscConfiguration process where a target node is missing a required module.

# Apply config to each target node (Assumes they have the same user, serviceaccount or WinRM is set up with certificate)
$Username = "Administrator"
$Password = "Abcd1234" | ConvertTo-SecureString -AsPlainText -Force
$Credentials =  New-Object System.Management.Automation.PSCredential($UserName,$Password)

Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials