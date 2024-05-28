function Process-Csv {
    param(
        [string]$CsvPath
    )

    $CsvData = Import-Csv -Path $CsvPath

    $Results = @()
    foreach ($Row in $CsvData){
        $Results += $Row.Name
    }

    return $Results

}

#Process-Csv -CsvPath .\organizations-100000.csv
#$Data = Process-Csv -CsvPath .\organizations-100000.csv
Measure-Command {Process-Csv -CsvPath .\organizations-100000.csv}