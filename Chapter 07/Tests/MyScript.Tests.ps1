BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe -Tag "Valid" "Blend-Colors" {
    
    Context "Test Valid Color combinations" {

        It "Blue and Red should be Purple" {
            $Color = Blend-Colors "Blue" "Red"
            $Color | Should -Be "Purple"
        }
        It "Red and Green should be Brown" {
            $Color = Blend-Colors "Red" "Green"
            $Color | Should -Be "Brown"
        }
        It "Blue and Green should be Teal" {
            $Color = Blend-Colors "Blue" "Green"
            $Color | Should -Be "Teal"
        }
    }
}

Describe -Tag "Unsupported" "Blend-Colors" {

    Context "Test unsopported Color Combinations" {
        It "Black and White should be Unsopported" {
            $Color = Blend-Colors "Black" "White"
            $Color | Should -Be "Unsupported Color Combination"
        }
        It "Green and Yellow should be Unsopported" {
            $Color = Blend-Colors "Green" "Yellow"
            $Color | Should -Be "Unsupported Color Combination"
        }
    }
}