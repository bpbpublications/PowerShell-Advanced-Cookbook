# New-PublicFuncOne.ps1
# Module: Logging
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This is an example public function that demonstrates how public functions
# can call private helper functions within the module.

function New-PublicFuncOne {
    <#
    .SYNOPSIS
        Example public function that uses a private helper.

    .DESCRIPTION
        Demonstrates the relationship between public and private functions
        in a PowerShell module. This function calls New-HelperFunction which
        is a private function not exported from the module.

    .EXAMPLE
        New-PublicFuncOne
        # Output: I Helped
    #>
    [CmdletBinding()]
    param()

    # Call the private helper function
    # Private functions are accessible within the module but not exported
    Write-Output "I $(New-HelperFunction)"
}
