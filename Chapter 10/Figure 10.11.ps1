# Retrieve Public IP address from httpbin.org
# Using PowerShell´s Invoke-RestMethod
$MyIp1 = (Invoke-RestMethod "http://httpbin.org/ip").origin
$MyIp1

# Using Azure CLI´s az rest command
$MyIp2 = az rest --method get --uri "http://httpbin.org/ip" --query "origin" --output tsv
$MyIp2