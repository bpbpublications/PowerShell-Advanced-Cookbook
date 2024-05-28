BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe "CodeCoverage" {
    Context "It tests function One" {
        It "Should return: Parameter is true" {
            One $true | Should -Be "Parameter is true"
        }
        It "Should return: Parameter is false" {
            One $false | Should -Be "Parameter is false"
        }
    }
    Context "It tests function Two" {
        It "Should return Failed" {
            Two $true | Should -Be "Failed"    
        }
        It "Should return Success" {
            Two $false | Should -Be "Success"
        }
    }
}