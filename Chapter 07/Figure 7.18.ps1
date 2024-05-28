# Functions for testing code coverage.
# function One {
#     param (
#         [Bool]$Parameter
#     )
#     if ($Parameter){
#         return "Parameter is true"
#     }
#     else{
#         return "Parameter is false"
#     }
# }

# function Two {
#     param (
#         [Bool]$Parameter = $false
#     )
#     try{
#         if ($Parameter){
#             throw "Failed"
#         }
#         $Output = "Success"
#     }
#     catch{
#         $Output = "$_"
#     }
#     return $Output
# }

# Test cases for code covering examples (100%)
# Describe "CodeCoverage" {
#     Context "It tests function One" {
#         It "Should return: Parameter is true" {
#             One $true | Should -Be "Parameter is true"
#         }
#         It "Should return: Parameter is false" {
#             One $false | Should -Be "Parameter is false"
#         }
#     }
#     Context "It tests function Two" {
#         It "Should return Failed" {
#             Two $true | Should -Be "Failed"    
#         }
#         It "Should return Success" {
#             Two $false | Should -Be "Success"
#         }
#     }
# }



# Create a Pester configuration. 
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"
$PesterConfig.CodeCoverage.Enabled = $true
$PesterConfig.CodeCoverage.CoveragePercentTarget = 85

# Invoke Pester using the configuration
Invoke-Pester -Configuration $PesterConfig