# This is images of the process when initializing Start-DscConfiguration cmdlet

# Start the configuration
Start-DscConfiguration -Path "C:\DSC\WebSite" -Wait -Force -Credential $Credentials 
