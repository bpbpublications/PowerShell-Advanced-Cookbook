# Recipe: Script with Main Function Using Sessions
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Demonstrates a well-structured script pattern for remote session management.

# ============================================================================
# SCRIPT PARAMETERS
# ============================================================================

# Accept the target computer name as a parameter
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, HelpMessage = "Target computer name")]
    [String]$ComputerName
)

# ============================================================================
# MAIN FUNCTION
# ============================================================================

function Main {
    <#
    .SYNOPSIS
        Executes remote commands on a target computer.

    .DESCRIPTION
        Creates a remote session, executes commands, and properly cleans up.
        Uses BEGIN/PROCESS/END blocks for proper lifecycle management.

    .NOTES
        The Main function pattern:
        - BEGIN: Setup and resource acquisition (create session)
        - PROCESS: Execute the actual work
        - END: Cleanup and resource release (remove session)
    #>
    [CmdletBinding()]
    param ()

    begin {
        # BEGIN block: Initialize resources
        # Create the remote session at the start
        # This ensures the session is ready before processing
        Write-Verbose "Creating remote session to $ComputerName"
        $Session = New-PSSession -ComputerName $ComputerName `
            -Credential (Get-Credential)
    }

    process {
        # PROCESS block: Execute the main logic
        # Run commands on the remote computer
        Write-Verbose "Executing remote command"
        Invoke-Command -Session $Session -ScriptBlock {
            $Env:COMPUTERNAME
        }
    }

    end {
        # END block: Cleanup resources
        # Always remove the session to free resources
        # This runs even if PROCESS encounters errors (when using try/finally)
        Write-Verbose "Removing remote session"
        Remove-PSSession $Session
    }
}

# ============================================================================
# SCRIPT ENTRY POINT
# ============================================================================

# Call the Main function to execute the script
Main

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

# Basic usage:
# .\Script.ps1 -ComputerName PS-HOST01

# With verbose output:
# .\Script.ps1 -ComputerName PS-HOST01 -Verbose

# Expected Output:
# (Credential prompt appears)
# PS-HOST01

# ============================================================================
# BEST PRACTICES DEMONSTRATED
# ============================================================================

# 1. CmdletBinding for advanced function features
# 2. Mandatory parameter with helpful message
# 3. Main function pattern for clean code organization
# 4. BEGIN/PROCESS/END lifecycle blocks
# 5. Session cleanup in END block
# 6. Verbose output for debugging
# 7. Comments explaining the purpose of each section
