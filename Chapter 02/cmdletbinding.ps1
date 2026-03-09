# CmdletBinding Attribute - Code Snippet
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This snippet demonstrates the CmdletBinding attribute and its options
# that transform basic functions into advanced functions.

# ============================================================================
# BASIC CMDLETBINDING
# ============================================================================

function Show-BasicCmdletBinding {
    # Just adding [CmdletBinding()] enables:
    # - Common parameters: -Verbose, -Debug, -ErrorAction, -WarningAction, etc.
    # - $PSCmdlet automatic variable
    # - Write-Verbose, Write-Debug support
    [CmdletBinding()]
    param ()

    Write-Verbose "This message only appears with -Verbose"
    Write-Debug "This message only appears with -Debug"
    Write-Output "Basic CmdletBinding function"
}

# ============================================================================
# CMDLETBINDING WITH OPTIONS
# ============================================================================

function Show-FullCmdletBinding {
    [CmdletBinding(
        # SupportsShouldProcess: Adds -WhatIf and -Confirm parameters
        SupportsShouldProcess = $true,

        # ConfirmImpact: When to auto-prompt for confirmation
        # "None", "Low", "Medium" (default), "High"
        ConfirmImpact = "High",

        # DefaultParameterSetName: Which parameter set to use by default
        DefaultParameterSetName = "Default",

        # SupportsPaging: Adds -First, -Skip, -IncludeTotalCount
        SupportsPaging = $true,

        # PositionalBinding: Allow positional parameters ($true by default)
        PositionalBinding = $true
    )]
    param (
        [Parameter(Mandatory = $true)]
        [String]$Name
    )

    # Access ShouldProcess via $PSCmdlet
    if ($PSCmdlet.ShouldProcess($Name, "Perform operation")) {
        Write-Output "Processing: $Name"
    }
}

# ============================================================================
# COMMON PARAMETERS ENABLED BY CMDLETBINDING
# ============================================================================

# When you add [CmdletBinding()], these parameters become available:
#
# -Verbose           : Show verbose messages (Write-Verbose)
# -Debug             : Show debug messages (Write-Debug)
# -ErrorAction       : Control error handling (Stop, Continue, SilentlyContinue, Ignore)
# -WarningAction     : Control warning handling
# -InformationAction : Control information handling
# -ErrorVariable     : Store errors in a variable
# -WarningVariable   : Store warnings in a variable
# -InformationVariable : Store information in a variable
# -OutVariable       : Store output in a variable
# -OutBuffer         : Buffer output before sending to pipeline
# -PipelineVariable  : Store current pipeline object in a variable

# ============================================================================
# USAGE EXAMPLES
# ============================================================================

Write-Output "=== Basic CmdletBinding ==="
Show-BasicCmdletBinding
Show-BasicCmdletBinding -Verbose

Write-Output ""
Write-Output "=== Full CmdletBinding with -WhatIf ==="
Show-FullCmdletBinding -Name "TestItem" -WhatIf

# Key Concepts:
# - [CmdletBinding()] is required for advanced function features
# - SupportsShouldProcess enables -WhatIf and -Confirm
# - ConfirmImpact controls when confirmation is automatic
# - $PSCmdlet provides access to cmdlet methods like ShouldProcess()
# - Common parameters are added automatically
