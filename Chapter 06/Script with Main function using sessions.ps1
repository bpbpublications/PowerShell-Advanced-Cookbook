[CmdletBinding()]
param (
    [String]$ComputerName
)
function Main {
    [CmdletBinding()]
    param (
    )

    begin {
        $Session = New-PSSession -ComputerName $ComputerName `
        -Credential (Get-Credential)
    }
    
    process {
        Invoke-Command -Session $Session -ScriptBlock {
            $Env:COMPUTERNAME
        }
    }
    
    end {
        Remove-PSSession $Session
    }
}

Main