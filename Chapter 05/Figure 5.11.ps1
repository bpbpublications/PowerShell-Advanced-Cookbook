#!/usr/bin/env pwsh

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [String]$FileName
)

switch ($true) {
    { $IsWindows } {
        # Code specific to Windows
        Write-Output "This platform is Windows"
        $TempPath = Join-Path "C:" "Temp"
    }
    { $IsLinux } {
        # Code specific to Linux
        Write-Output "This platform is Linux"
        $TempPath = Join-Path "/" "home" "Temp"
    }
    { $IsMacOS } {
        # Code specific to MacOS
        Write-Output "This platform is MacOS"
        $TempPath = Join-Path "/" "home" "Temp"
    }
    default {
        exit "This platform is Unsupported"
    }
}

$InfoFile = Join-Path $TempPath $FileName

$Info = [PSCustomObject]@{
    OS                    = ($PSVersionTable).OS
    Platform              = ($PSVersionTable).Platform
    PSVersion             = (($PSVersionTable).PSVersion).ToString()
    "Get-ChildItem-Alias" = (Get-Alias -Definition Get-ChildItem).DisplayName
}

$Info | ConvertTo-Json | Out-File $InfoFile -Force

