function Remove-Superhero {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [String[]]$Name,
        [Parameter(Position = 1)]
        [String]$HeroesVariable = "Heroes"
    )

    Begin {
        if (-not (Get-Variable -Name $HeroesVariable -Scope Global -ErrorAction SilentlyContinue)) {
            throw "Global variable '$HeroesVariable' not found."
        }

        $Heroes = Get-Variable -Name $HeroesVariable -Scope Global -ValueOnly
        $Changes = $false
    }

    Process {
        if (-not $Heroes.ContainsKey("$Name")) {
            Write-Verbose "$HeroesVariable does not contain a Superhero name: $Name"
            Return
        }
        elseif ($PSCmdlet.ShouldProcess("$Name")) {
            $Heroes.Remove("$Name")
            Write-Verbose "Superhero: $Name removed"
            $Changes = $true
        }
    }

    End {
        if ($Changes){
            Write-Verbose "Removed Superheroes from and updated the global variable: $HeroesVariable"
        }
        else{
            Write-Verbose "No changes where made to the global variable: $HeroesVariable"
        }
    }
}


function Remove-File {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = "High")]
    param (
        [Parameter(Position = 0, Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [String]$File
    )

    # $PSCmdlet.ShouldProcess("Target")
    if ($PSCmdlet.ShouldProcess($File)) {
        Remove-Item -Path $File
    }
    # $PSCmdlet.ShouldProcess("Target", "Action")
    if ($PSCmdlet.ShouldProcess($File, "Remove")) {
        Remove-Item -Path $File
    }
    # $PSCmdlet.ShouldProcess("Message", "Target", "Action")
    if ($PSCmdlet.ShouldProcess("RemoveMessage", $File, "Remove")) {
        Remove-Item -Path $File
    }
}

