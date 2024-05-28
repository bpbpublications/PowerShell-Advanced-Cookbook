# Delete a vm
az vm delete `
--resource-group "TestVM" `
--name "TestVM" `
--yes

# List resources in a specific resource group
# Using Azure CLI table output
az resource list --resource-group "TestVM" --output table