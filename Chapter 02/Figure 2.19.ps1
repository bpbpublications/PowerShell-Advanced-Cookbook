# Figure 2.19 - ValueFromPipeline accepts entire objects from the pipeline
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications

# This demonstrates ValueFromPipeline - the parameter receives the ENTIRE object
# from the pipeline, not just a specific property.

function Add-ValueFromPipeline {
    [CmdletBinding()]
    param (
        # ValueFromPipeline means this parameter receives whatever comes through
        # the pipeline as a whole object
        [Parameter(ValueFromPipeline)]
        [PSObject]$Obj
    )

    # ========================================================================
    # PROCESS BLOCK - Required for pipeline processing
    # ========================================================================
    # Without Process block, only the LAST pipeline item would be processed!

    Process {
        # Since we receive the whole object, we access properties via $Obj.PropertyName
        Write-Output "$($Obj.Name) is $($Obj.Age) years old"
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

Write-Output "=== Pipeline with ValueFromPipeline ==="

# Each object flows through the pipeline one at a time
# Process block runs once per object
$Data | Add-ValueFromPipeline

# Expected Output:
# Comet is 43 years old
# Blue Ghost is 207 years old
# Evilin is 33 years old

# ============================================================================
# COMPARISON: WITHOUT PROCESS BLOCK (WRONG!)
# ============================================================================

# If we didn't have a Process block, this would happen:
# function BadExample {
#     param ([Parameter(ValueFromPipeline)][PSObject]$Obj)
#     Write-Output "$($Obj.Name) is $($Obj.Age) years old"
# }
# $Data | BadExample  # Would only output "Evilin is 33 years old" (last item!)

# Key Concepts:
# - ValueFromPipeline receives the ENTIRE object from the pipeline
# - The Process block is essential - it runs once per pipeline object
# - Without Process block, only the last item gets processed
# - Access object properties via $Obj.PropertyName syntax
# - Compare with Figure 2.20 which uses ValueFromPipelineByPropertyName instead
