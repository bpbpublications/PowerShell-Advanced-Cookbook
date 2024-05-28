:OuterLoop foreach ($Outer in 1..3) {
    Write-Host "Outer Loop: $Outer"
    :InnerLoop foreach ($Inner in 1..3) {
        if ($Inner -eq 2) {
            Write-Host "Continuing next iteration of the inner loop..."
            continue OuterLoop
        }
        Write-Host "Inner Loop: $Inner"
    }
}


