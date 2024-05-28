# Blend-Colors test cases
# Describe -Tag "Colors" "Blend-Colors" {
    
#     Context "Test Valid color combinations" {

#         It "Blue and Red should be Purple" {
#             $Color = Blend-Colors "Blue" "Red"
#             $Color | Should -Be "Purple"
#         }
#         It "Red and Green should be Brown" {
#             $Color = Blend-Colors "Red" "Green"
#             $Color | Should -Be "Brown"
#         }
#         It "Blue and Green should be Teal" {
#             $Color = Blend-Colors "Blue" "Green"
#             $Color | Should -Be "Teal"
#         }
#     }

#     Context "Test unsupported color Combinations" {
#         It "Black and White should be Unsupported" {
#             $Color = Blend-Colors "Black" "White"
#             $Color | Should -Be "Unsupported Color Combination"
#         }
#         It "Green and Yellow should be Unsupported" {
#             $Color = Blend-Colors "Green" "Yellow"
#             $Color | Should -Be "Unsupported Color Combination"
#         }
#     }
# }

# Updated Blend-Colors function with introduced mistake (missing e in purple)
# function Blend-Colors {
#     [CmdletBinding()]
#     param (
#         [String]$Color1,
#         [String]$Color2
#     )
#     Write-Verbose "Input colors: $Color1 and $Color2"
#     switch -Regex ("$Color1 $Color2") {
#         "Red Blue|Blue Red" { 
#             Write-Verbose "Output color: Purple"
#             return "Purpl" }
#         "Red Green|Green Red" { 
#             Write-Verbose "Output color: Brown"
#             return "Brown" }
#         "Blue Green|Green Blue" { 
#             Write-Verbose "Output color: Teal"
#             return "Teal" }
#         default { return "Unsupported Color Combination" }
#     }
# }


# Create a Pester configuration. Save the configuration in a Configuration file
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# dot source the configuration file into the current session
# The path must be to the config file!
. ..\PesterConfigs\PesterConfig-Detailed.ps1

# Invoke Pester using the configuration from the configuraition file
Invoke-Pester -Configuration $PesterConfig