# Create a Virtual machine
az vm create `
--resource-group "TestVM" `
--name "TestVM" `
--image "Win2022Datacenter" `
--size "Standard_B2s" `
--admin-username "TestUser" `
--admin-password "@Test123456789" `
--location "westeurope"