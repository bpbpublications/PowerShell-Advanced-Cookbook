# Always be logged into Azure before running az commands
az login

# If you have multiple subscriptions, select the specific subscription you want to work within.
az account set --subscription <Subscription ID>

# Create resource group
$GroupName = "TestVM"
$Location = "westeurope"
az group create --name $GroupName --location $Location
