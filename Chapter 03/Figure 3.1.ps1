foreach ($Outer in 1..5){
    foreach ($Inner in 1..5){
        Write-Output "$Outer x $Inner = $($Outer * $Inner)"
    }
}
