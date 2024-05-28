function One {
    param (
        [Bool]$Parameter
    )
    if ($Parameter){
        return "Parameter is true"
    }
    else{
        return "Parameter is false"
    }
}
function Two {
    param (
        [Bool]$Parameter = $false
    )
    try{
        if ($Parameter){
            throw "Failed"
        }
        $Output = "Success"
    }
    catch{
        $Output = "$_"
    }
    return $Output
}
