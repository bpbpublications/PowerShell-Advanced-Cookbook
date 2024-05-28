# This should be in the context of the new created RM user
# With the permissions from the RMGroup

# List another user (Test3)
Get-IAMUser Test3 | Select-Object UserName

# Remove the Test3 user 
Remove-IAMUser Test3 -Confirm:$false

# List Test3 user after deletion
Get-IAMUser Test3 | Select-Object UserName