# Prerequisites for this Figure
Set-Location ".\Modules\Logging"

New-ModuleManifest -Path Logging.psd1 `
-Author "Morten E. Hansen" `
-RootModule Logging.psm1 `
-ModuleVersion 1.0.0 `
-FunctionsToExport "Add-LogToJson" `
-Description "Contains misc. Logging functions"