[CmdletBinding()]
param (
    [Parameter(Position=0)]
    [String]$ResourceGroup = "RG-Infrastructure",
    [Parameter(Position=1)]
    [String]$Location = "westeurope",
    [Parameter(Position=2)]
    [String[]]$VMs = @("VmOne", "VmTwo", "VmThree"),
    [Parameter(Position=3)]
    [String]$ConfigPath = ".\Infrastructure.config"
)

[xml]$Config = Get-Content $ConfigPath

# Login to Azure using Service Principal
az login --service-principal `
--username "$($Config.Azure.UserName)" `
--password="$($Config.Azure.Password)" `
--tenant "$($Config.Azure.TenantID)"

foreach ($Vm in $VMs){
    az vm create `
    --resource-group $ResourceGroup `
    --name $Vm `
    --image "Win2022Datacenter" `
    --size "Standard_B2s" `
    --admin-username "TestUser" `
    --admin-password "@Test123456789" `
    --location $Location
}

# Logut
az logout

# Example:
.\Infrastructure.ps1 -ResourceGroup "RG-New" `
-Location "East Us" `
-VMs "TestVm", "DevVM", "StagingVM", "PocVM", "ProdVM" `
-ConfigPath "C:\Configs\RG-New.config"