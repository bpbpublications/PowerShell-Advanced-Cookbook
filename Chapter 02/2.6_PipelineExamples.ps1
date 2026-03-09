# Pipeline Examples - Code Snippet
# Chapter 2: Advanced PowerShell Functions
# PowerShell Advanced Cookbook - BPB Publications
#
# This snippet demonstrates the difference between ValueFromPipeline
# and ValueFromPipelineByPropertyName.

# ============================================================================
# METHOD 1: ValueFromPipeline - Receives ENTIRE object
# ============================================================================

function Add-ValueFromPipeline {
    [CmdletBinding()]
    param (
        # Receives the whole object from the pipeline
        [Parameter(ValueFromPipeline)]
        [PSObject]$Obj
    )

    Process {
        # Access properties via $Obj.PropertyName
        Write-Output "$($Obj.Name) is $($Obj.Age) years old"
    }
}

# ============================================================================
# METHOD 2: ValueFromPipelineByPropertyName - Receives individual properties
# ============================================================================

function Add-ValueFromPipelineByPropertyName {
    [CmdletBinding()]
    param (
        # Parameter name MUST match property name on pipeline objects
        [Parameter(ValueFromPipelineByPropertyName)]
        [String]$Name,

        [Parameter(ValueFromPipelineByPropertyName)]
        [Int]$Age
    )

    Process {
        # Use parameters directly - no $Obj.PropertyName needed
        Write-Output "$Name is $Age years old"
    }
}

# ============================================================================
# TEST DATA
# ============================================================================

$Data = @(
    [PSCustomObject]@{ Name = "Comet";      Age = 43  }
    [PSCustomObject]@{ Name = "Blue Ghost"; Age = 207 }
    [PSCustomObject]@{ Name = "Evilin";     Age = 33  }
)

# ============================================================================
# COMPARISON
# ============================================================================

Write-Output "=== Using ValueFromPipeline ==="
$Data | Add-ValueFromPipeline

Write-Output ""
Write-Output "=== Using ValueFromPipelineByPropertyName ==="
$Data | Add-ValueFromPipelineByPropertyName

# Expected Output:
# Comet is 43 years old
# Blue Ghost is 207 years old
# Evilin is 33 years old

# Key Concepts:
# - ValueFromPipeline: Gets the WHOLE object → access via $Obj.Property
# - ValueFromPipelineByPropertyName: Gets individual properties → use directly
# - Both require the Process block for proper pipeline handling
# - Property names must match parameter names for ByPropertyName
