# New-HelperFunction.ps1
# Module: Logging (Private)
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This is a private helper function. It is NOT exported from the module
# and can only be called by other functions within the Logging module.

function New-HelperFunction {
    <#
    .SYNOPSIS
        Private helper function example.

    .DESCRIPTION
        This function is in the Private folder and is not exported.
        It can only be called by functions within the Logging module.
        External callers will get "command not found" error.

    .NOTES
        Private functions:
        - Are placed in the Private folder
        - Are NOT listed in FunctionsToExport in the manifest
        - Cannot be called after Import-Module
        - Are used for internal module operations
    #>
    [CmdletBinding()]
    param()

    return "Helped"
}
