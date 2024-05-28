# Retrieve Public IP address from httpbin.org
# Using PowerShell´s Invoke-RestMethod
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# Create NSG rule to allow WinRM
az network nsg rule create `
--resource-group "TestVM" `
--nsg-name "TestVMNSG" `
--name "WinRM" `
--source-address-prefix $MyIp1 `
--destination-port-range 5985 `
--priority 1001 `
--protocol "TCP"