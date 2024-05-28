BeforeAll {
    . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
}

Describe -Tag "Linux" "Linux Tests" {
    Context "Strings" {   
        It "Must be a Linux String" {
            $String = Linux-String
            $String | Should -Be "I am a Linux String"
        }
    }
    Context "Paths" {
        It "Must be the Root Path" {
            $Path = Linux-RootPath
            $Path | Should -Be "/"
        }
    }
}

Describe -Tag "Windows" "Windows Tests" {
    Context "Strings" {   
        It "Must be a Windows String" {
            $String = Windows-String
            $String | Should -Be "I am a Windows String"
        }
    }
    Context "Paths" {
        It "Must be the Root Path" {
            $Path = Windows-RootPath
            $Path | Should -Be "C:\"
        }
    }
}

Describe "MacOS Tests" {
    Context "Strings" {   
        It "Must be a MacOS String" {
            $String = MacOS-String
            $String | Should -Be "I am a MacOS String"
        }
    }
    Context "Paths" {
        It "Must be the Root Path" {
            $Path = MacOS-RootPath
            $Path | Should -Be "/"
        }
    }
}