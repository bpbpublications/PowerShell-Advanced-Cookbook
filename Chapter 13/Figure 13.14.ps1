# This shows how an LCM auto re-applies a resource that have manually been removed:

# View DSCNODE registry
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Remove DSCNODE registry
Remove-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# View DSCNODE registry
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# View DSCNODE registry
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE
