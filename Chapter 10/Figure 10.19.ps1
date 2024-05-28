# Delete resources commands

# # Delete disk
# az disk delete `
# --resource-group "TestVM" `
# --name "TestVM_OsDisk_1_d4110a26c79b45de873a3143055e56db"

# # Delete network interface (NIC)
# az network nic delete `
# --resource-group "TestVM" `
# --name "TestVMVMNic"

# # Delete NSG
# az network nsg delete `
# --resource-group "TestVM" `
# --name "TestVMNSG"

# # Delete Public IP address
# az network public-ip delete `
# --resource-group "TestVM" `
# --name "TestVMPublicIP"

# # Delete virtual network
# az network vnet delete `
# --resource-group "testVM" `
# --name "TestVMVNET"

# Delete resource group
az group delete `
--name "TestVM"

# Will prompt for confirmation

# List resources in a specific resource group (After all resources have been deleted)
# Using Azure CLI table output
az resource list --resource-group "TestVM" --output table