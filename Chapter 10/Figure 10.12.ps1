# Retrieve Public IP address from httpbin.org
# Using PowerShell´s Invoke-RestMethod
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# Update NSG Rule
az network nsg rule update `
--resource-group "TestVM" `
--nsg-name "TestVMNSG" `
--name "rdp" `
--source-address-prefix $MyIp1