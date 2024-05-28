
function Blend-Colors {
    [CmdletBinding()]
    param (
        [String]$Color1,
        [String]$Color2
    )
    Write-Verbose "Input colors: $Color1 and $Color2"
    switch -Regex ("$Color1 $Color2") {
        "Red Blue|Blue Red" { 
            Write-Verbose "Output color: Purple"
            return "Purple" }
        "Red Green|Green Red" { 
            Write-Verbose "Output color: Brown"
            return "Brown" }
        "Blue Green|Green Blue" { 
            Write-Verbose "Output color: Teal"
            return "Teal" }
        default { return "Unsupported Color Combination" }
    }
}