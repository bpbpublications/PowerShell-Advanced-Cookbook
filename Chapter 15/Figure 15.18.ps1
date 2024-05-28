# This is a Figure with code specific for installing the weatherlogservice

# List the service
Get-Service -Name "WeatherLogService"

# Install the service:
.\WeatherLogService.exe -install

# List the service
Get-Service -Name "WeatherLogService"

# Uninstall the service:
.\WeatherLogService.exe -uninstall

# List the service
Get-Service -Name "WeatherLogService"
