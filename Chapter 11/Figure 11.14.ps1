# Expects you to be authenticated with a user with proper permissions

# List and search for policies
Get-IAMPolicies | Where-Object {$_.PolicyName -match "List"} | Select-Object PolicyName,Arn
