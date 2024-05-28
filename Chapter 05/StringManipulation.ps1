# String concatenation ( + operator)
$First = "Lightning"
$Last = "Girl"
$Name = $First + " " + $Last

#PS C:\Temp> $Name
#Lightning Girl

#######################################

# String search and replace (String method)
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text.Replace("Villains", "Heroes")

#PS C:\Temp> $Text
#These superheroes are Heroes: Comet, Lightning Girl

# String search and replace (Operator)
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text -replace "Villains", "Heroes"

#PS C:\Temp> $Text
#These superheroes are Heroes: Comet, Lightning Girl

# String search and replace (Operator - Case-Insensitive)
$Text = "These superheroes are Villains: Comet, Lightning Girl"
$Text = $Text -ireplace "villains", "heroes"

#PS C:\Temp> $Text
#These superheroes are heroes: Comet, Lightning Girl

# String search and replace (Operator - RegEx Pattern)
$Text = "Comet has 47 HitPoints, Lightning Girl has 25 HitPoints"
$Text = $Text -replace "\d+", "50"

#PS C:\Temp> $Text
#Comet has 50 HitPoints, Lightning Girl has 50 HitPoints

#######################################

# Substring extraction (String method, two arguments)
$Text = "Lightning Girl meets Comet"
$Substring = $Text.Substring(10,4)

#PS C:\Temp> $Substring
#Girl

# Substring extraction (String method, one argument)
$Text = "Lightning Girl meets Comet"
$Substring = $Text.Substring(10)

#PS C:\Temp> $Substring
#Girl meets Comet

#######################################

$Text = "My personal email is email@home.com and my work email is email@work.com"
$Emails = [regex]::Matches($Text, "[a-zA-Z0–9._%+-]+@[a-zA-Z0–9.-]+\.[a-zA-Z]{2,}") | ForEach-Object { $_.Value }

#PS C:\Temp> $Emails
#email@home.com
#email@work.com


$Text = "Server 1: 192.168.1.100, Server 2: 10.0.0.2, Gateway: 172.16.0.1"
$IPAddresses = [regex]::Matches($Text, "\b(?:\d{1,3}\.){3}\d{1,3}\b") | ForEach-Object { $_.Value }

#PS C:\Temp> $IPAddresses
#192.168.1.100
#10.0.0.2
#172.16.0.1


$Text = "Device 1: AA:BB:CC:DD:EE:FF, Device 2: 11:22:33:44:55:66, Device 3: 00:11:22:33:44:55"
$MACAddresses = [regex]::Matches($Text, "([0-9A-Fa-f]{2}[:-]){5}([0-9A-Fa-f]{2})") | ForEach-Object { $_.Value }

#PS C:\Temp> $MACAddresses
#AA:BB:CC:DD:EE:FF
#11:22:33:44:55:66
#00:11:22:33:44:55


#######################################

# Splitting string using Split() method
$Text = "Comet;Lightning Girl;Blue Ghost;Evilin"
$Array = $Text.Split(";")

#PS C:\Temp> $Array
#Comet
#Lightning Girl
#Blue Ghost
#Evilin

# Splitting string using -split operator
$Text = "Comet;Lightning Girl;Blue Ghost;Evilin"
$Array = $Text -split ";"

#PS C:\Temp> $Array
#Comet
#Lightning Girl
#Blue Ghost
#Evilin

# Splitting string using -split operator and regex delimiter pattern
$Text = "Comet;Lightning Girl,Blue Ghost#Evilin"
$Array = $Text -split "[;,#]"

#PS C:\Temp> $Array
#Comet
#Lightning Girl
#Blue Ghost
#Evilin

#######################################

# Joining string array with -join operator and ; as delimiter
$Array = @(
    "Comet",
    "Lightning Girl",
    "Blue Ghost",
    "Evilin"
    )

$Text = $Array -join ";"

#PS C:\Temp> $Text
#Comet;Lightning Girl;Blue Ghost;Evilin

# Joining string array with -join operator and empty string as delimiter
$Array = @(
    "Comet",
    "Lightning Girl",
    "Blue Ghost",
    "Evilin"
    )

$Text = $Array -join ""

#PS C:\Temp> $Text      
#CometLightning GirlBlue GhostEvilin



#######################################

# Using string Trim() method to remove only whitespace
$Text = "     Villains vs. Heroes      "
$Text = $Text.Trim()

#PS C:\Temp> $Text
#Villains vs. Heroes

# Using string Trim() method to remove only *
$Text = "***     Villains vs. Heroes      ***"
$Text = $Text.Trim("*")

#PS C:\Temp> $Text
#     Villains vs. Heroes  

# Using string Trim() method with pattern to remove whitespace and *
$Text = "***     Villains vs. Heroes      ***"
$Text = $Text.Trim("[* ]")

#PS C:\Temp> $Text
#Villains vs. Heroes

#######################################

# String conversion to UPPERCASE
$Text = "Comet is a Hero"
$Text = $Text.ToUpper()

#PS C:\Temp> $Text
#COMET IS A HERO

# String conversion to lowercase
$Text = "COMET is a Hero"
$Text = $Text.ToLower()

#PS C:\Temp> $Text
#comet is a hero

#######################################

# Left aligned padding with PadLeft() method
$Text = "Lightning Girl"
$Text = $Text.PadLeft(20)

#PS C:\Temp> """$Text"""
#"      Lightning Girl"

# Right aligned padding with PadRight() method
$Text = "Lightning Girl"
$Text = $Text.PadRight(20)

#PS C:\Temp> """$Text"""
#"Lightning Girl      "

# Using * as padding character
$Text = "Lightning Girl"
$Text = $Text.PadRight(20, "*")

#PS C:\Temp> """$Text"""
#"Lightning Girl******"

# Add equally left and right aligned padding with * as padding character
$Text = "Lightning Girl"
$Padding = 20
$Text = $Text.PadLeft($Padding, "*").PadRight( $Padding + ($Padding - $Text.Length) , "*")

#PS C:\Temp> """$Text"""
#"*****Lightning Girl*****"

