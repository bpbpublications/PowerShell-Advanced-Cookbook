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

Remove-File .\Test.ps1 -WhatIf