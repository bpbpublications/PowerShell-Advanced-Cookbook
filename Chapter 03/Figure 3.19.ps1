function Process-CsvJob {
    param(
        [string]$CsvPath,
        [int]$ParallelJobs = 4
    )
    # Define the script block for processing each data row
    $ProcessRowScriptBlock = {
        param($JobNumber, $Chunk)
        $Results = @()
        foreach ($Row in $Chunk) {
            $Name = $Row.Name
            # Add the processed result with the job number to the results array
            $Results += "Job $jobNumber : Processed $Name"
        }
        # Return the results array
        return $Results
    }
    
    # Import the csv file into a variable
    $CsvData = Import-Csv -Path $CsvPath
    
    # Create an array to store the PowerShell jobs
    $Jobs = @()
    
    # Divide the data into chunks to distribute among parallel jobs
    $ChunkSize = [Math]::Ceiling($CsvData.Count / $ParallelJobs)
    
    # Create jobs and start parallel processing
    for ($JobNumber = 1; $JobNumber -le $ParallelJobs; $JobNumber++) {
        $StartIndex = ($JobNumber - 1) * $ChunkSize
        $EndIndex = [Math]::Min(($StartIndex + $ChunkSize - 1), ($CsvData.Count - 1))
        $Chunk = $CsvData[$StartIndex..$EndIndex]
        $Job = Start-Job -ScriptBlock $ProcessRowScriptBlock -ArgumentList $JobNumber, $Chunk
        $Jobs += $Job
    }
    
    # Wait for all jobs to complete
    Wait-Job -Job $Jobs

    # Receive all job results
    $Result = Receive-Job $Jobs
    
    # Remove the jobs (Cleanup)
    Remove-Job $Jobs

    return $Result
}

Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4
#Measure-Command {Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 4}
#Measure-Command {Process-CsvJob -CsvPath .\organizations-100000.csv -ParallelJobs 10}