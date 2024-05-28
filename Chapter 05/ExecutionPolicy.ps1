# Get the current execution policy
Get-ExecutionPolicy

# Get a list of execution policies for all scopes
Get-ExecutionPolicy -List

# Get execution policy for a specific scope
# Get-ExecutionPolicy -Scope <Scope>
Get-ExecutionPolicy -Scope Process

# Set the execution policy
# Set-ExecutionPolicy -ExecutionPolicy <Policy>
Set-ExecutionPolicy -ExecutionPolicy AllSigned

# Set the execution policy for a specific scope
# Set-ExecutionPolicy -ExecutionPolicy <Policy> -Scope <Scope>
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope Process

# Remove the execution policy (Set as undefined)
Set-ExecutionPolicy -ExecutionPolicy Undefined

# Remove the execution policy for a specifc scope (Set as undefined)
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process