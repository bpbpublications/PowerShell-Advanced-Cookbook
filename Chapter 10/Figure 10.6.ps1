# convert and filter az commands using ConvertFrom-Json and Select-Object
az group list | ConvertFrom-Json | Select-Object Name,Location,Properties