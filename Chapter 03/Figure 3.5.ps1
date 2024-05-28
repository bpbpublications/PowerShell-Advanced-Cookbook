foreach ($Outer in 1..3){
    foreach ($Inner in 1..3){
        if ($Inner -eq 2){
            continue
        }
        Write-Output "$Outer x $Inner = $($Outer * $Inner)"
    }
}

