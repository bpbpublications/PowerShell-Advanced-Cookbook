# List resources in a specific resource group

# Using Azure CLI table output
az resource list --resource-group "TestVM" --output table

# Using converted and filtered output
az resource list --resource-group "TestVM" | `
ConvertFrom-Json | `
Select-Object Name,Type