# String interpolation with string variables
$Hero = "Comet"
$Villain = "Evilin"

$Text = "The hero is: $Hero and the villain is: $Villain"

#PS C:\Temp> $Text
#The hero is: Comet and the villain is: Evilin

# String interpolation with different datatype variables
$String = "Superhero"
$Integer = 25
$Bool = $true

$Text = "This is a string: $String This is an integer: $Integer and this is a bool: $Bool"

#PS C:\Temp> $Text
#This is a string: Superhero This is an integer: 25 and this is a bool: True

#######################################

# String formatting with the -f operator
$Hero = "Comet"
$Villain = "Evilin"

$Text = "The hero is: {0} and the villain is: {1}" -f $Hero, $Villain

#PS C:\Temp> $Text                
#The hero is: Comet and the villain is: Evilin

# String formatting with the -f operator and the Number (N) format specifier
[double]$Float = 3.16543

$Text = "The villain has {0:N2}% chance of beating this hero" -f $Float

#PS C:\Temp> $Text
#The villain has 3,17% chance of beating this hero

# String formatting with the -f operator and a Custom  format specifier
$Date = Get-Date

$Text = "A new superhero is born the {0:dd-MM-yyyy} at {1:HH:mm:ss}" -f $Date, $Date

#PS C:\Temp> $Text
#A new superhero is born the 08-08-2023 at 14:47:06

#######################################

# Using subexpression operator to evaluate expression
$Hero = [PSCustomObject]@{
    Strength = 55
    Level = 7
}
$Text = "The hero´s total power is: $($Hero.Strength * $Hero.Level)"

#PS C:\Temp> $Text
#The hero´s total power is: 385

# Using subexpression operator to evaluate command
function New-Date{
    return Get-Date -f "dd-MM-yyyy HH:mm:ss"
}

$Text = "A new hero is born: $(New-Date)"

#PS C:\Temp> $Text
#A new hero is born: 09-08-2023 09:25:30

# Using subexpression operator to evaluate command
$Text = "StatusCode: $( (Invoke-WebRequest google.com).StatusCode )"

#PS C:\Temp> $Text
#StatusCode: 200

#######################################

$Text = "Backtics can be used to escape `"quotes`" inside strings"

#PS C:\Temp> $Text
#Backtics can be used to escape "quotes" inside strings

$Text = "`"And in escape sequences like newlines`nand tabs`twhich is cool`""

#PS C:\Temp> $Text
#"And in escape sequences like newlines
#and tabs        which is cool"

#######################################

$Hero = "Comet"

$Text = @"
Double quoted Here-strings a perfect for creating multiline strings.
You can interpolate variables: $Hero
use subexpressions: $(Get-Date) 
and even use the format {0}.
"@ -f "operator"

#PS C:\Temp> $Text
#Here strings a perfect for creating multiline strings.
#You can interpolate variables: Comet
#use subexpressions: 08/09/2023 10:02:39 
#and even use the format operator
#inside a here-string.

$Hero = "Comet"

$Text = @'
Single quoted Here-strings a perfect for creating multiline strings.
But you cannot interpolate variables: $Hero
or use subexpressions: $(Get-Date) 
But you can still use the format {0}.
'@ -f "operator"

#PS C:\Temp> $Text     
#Single quoted Here-strings a perfect for creating multiline strings.
#But you cannot interpolate variables: $Hero
#or use subexpressions: $(Get-Date) 
#But you can still use the format operator.

#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################
#######################################