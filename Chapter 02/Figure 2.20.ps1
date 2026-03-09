# Figure 2.20 - ValueFromPipelineByPropertyName maps properties to parameters
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates ValueFromPipelineByPropertyName - parameters are automatically
# bound to matching property names from pipeline objects.

function Add-ValueFromPipelineByPropertyName {
    [CmdletBinding()]
    param (
        # Parameter name MUST match the property name on the pipeline object
        # PowerShell automatically extracts "Name" from each object
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Name,

        # Same here - "Age" property from pipeline object binds to $Age parameter
        [Parameter(ValueFromPipelineByPropertyName)]
        [Int]$Age
    )

    # ========================================================================
    # PROCESS BLOCK - Runs once per pipeline object
    # ========================================================================

    Process {
        # Here we use $Name and $Age directly - no need for $_.Name or $Obj.Name
        Write-Output "$Name is $Age years old"
    }
}

# ============================================================================
# CREATE TEST DATA
# ============================================================================

$Data = @(
    [PSCustomObject]@{ Name = "Comet";      Age = 43  }
    [PSCustomObject]@{ Name = "Blue Ghost"; Age = 207 }
    [PSCustomObject]@{ Name = "Evilin";     Age = 33  }
)

# ============================================================================
# PIPELINE EXECUTION
# ============================================================================

Write-Output "=== Pipeline with ValueFromPipelineByPropertyName ==="

# PowerShell extracts Name and Age properties from each object
# and binds them to the matching parameter names
$Data | Add-ValueFromPipelineByPropertyName

# Expected Output:
# Comet is 43 years old
# Blue Ghost is 207 years old
# Evilin is 33 years old

# ============================================================================
# KEY DIFFERENCE FROM ValueFromPipeline
# ============================================================================

# ValueFromPipeline:               Gets the WHOLE object → $Obj
# ValueFromPipelineByPropertyName: Gets individual PROPERTIES → $Name, $Age

# ValueFromPipelineByPropertyName is cleaner when you only need specific properties
# and want direct access without $Obj.PropertyName syntax

# ============================================================================
# COMBINING BOTH APPROACHES
# ============================================================================

# You can use both on the same parameter if needed:
# [Parameter(ValueFromPipeline, ValueFromPipelineByPropertyName)]
# This allows the function to accept both whole objects AND property-based binding

# Key Concepts:
# - Parameter names must match property names on the pipeline objects
# - PowerShell automatically extracts and binds matching properties
# - Process block is still required for processing each item
# - This is cleaner than ValueFromPipeline when you know the exact properties
# - Works great with Import-Csv since CSV column names become property names
