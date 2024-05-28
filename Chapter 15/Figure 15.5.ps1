# Code for this example in the script segment file.
# This contains control event code and a simple function


$formTestApplication_Load={
	#TODO: Initialize Form Controls here
	
}

$buttonClick_Click={
	#TODO: Place custom script here
	$label1.Text = Add-Date
	
}

function Add-Date
{
	$Date = Get-Date -Format "dd-MM-yyyy HH:mm"
	return "[$($Date)]: $($textbox1.Text)"
}