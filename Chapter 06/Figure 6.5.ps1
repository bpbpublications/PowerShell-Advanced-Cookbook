# Figure 6.5 - Run Script with Parameters on Remote Host
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates running a local script on a remote computer with arguments.

# ============================================================================
# INVOKE-COMMAND WITH SCRIPT FILE
# ============================================================================

# -FilePath runs a LOCAL script on the REMOTE computer
# The script content is transferred, not the file reference
# -ArgumentList passes parameters to the script's param() block
Invoke-Command -ComputerName PS-Host01 `
    -FilePath C:\Temp\GetComputerName.ps1 `
    -ArgumentList "$($Env:COMPUTERNAME)" `
    -Credential (Get-Credential)

# Expected Output:
# This script is run on PS-HOST01 from YOURCOMPUTERNAME

# ============================================================================
# REFERENCE: GetComputerName.ps1 Script Content
# ============================================================================

# The GetComputerName.ps1 script should contain:
# [CmdletBinding()]
# param (
#     [String]$ClientHostName
# )
#
# Write-Output "This script is run on $($Env:COMPUTERNAME) from $ClientHostName"

# How it works:
# 1. Script file from local path is read and serialized
# 2. Script content is transferred to remote computer
# 3. Script executes in remote PowerShell session
# 4. $ClientHostName receives the value from -ArgumentList
# 5. $Env:COMPUTERNAME on remote host returns the remote hostname

# Note: The script file does not need to exist on the remote computer
# Note: Multiple arguments are passed as comma-separated values:
# -ArgumentList "arg1", "arg2", "arg3"
