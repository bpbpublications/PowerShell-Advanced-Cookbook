# -Be - Checks Equality. Case Insensitive
"STRING" | Should -Be "String" #Pass

# -BeExactly - Checks Equality. Case Sensitive
"STRING" | Should -BeExactly "String" #Fail
"STRING" | Should -BeExactly "STRING" #Pass

# -Exist - Checks if file/directory exists
"C:\Temp\TestFile.txt" | Should -Exist 
# Fails if file/direcotry does not exist
# Pass if file/direcotry exists

# -Contain - Check if collection, file or string contains a specific value
# Case Insensitive
"String" | Should -Contain "s" #Pass
"String" | Should -Contain "T" #Fail
"Blue", "Green", "Red" | Should -Contain "blue" #Pass
"Blue", "Green", "Red" | Should -Contain "Yellow" #Fail
"C:\Temp\TestFile.txt" | Should -Contain "Word"
# Fails if file does not contain "Word"
# Pass if file contains "Word"

# -ContainExactly - Check if collection, file or string contains a specific value
# Case Sensitive
"String" | Should -Contain "s" #Fail
"String" | Should -Contain "S" #Pass
"Blue", "Green", "Red" | Should -Contain "blue" #Fail
"Blue", "Green", "Red" | Should -Contain "Red" #Pass
"C:\Temp\TestFile.txt" | Should -Contain "Word"
# Fails if file does not contain "Word"
# Fails if file contains "word"
# Pass if file contains "Word"

# -Match - Uses a RegEx for comparison. Case Insensitive
"This is True" | Should -Match "This is" #Pass
"This is True" | Should -Match "This is not true" #Fail

# -MatchExactly - Uses a RegEx for comparison. Case Sensitive
"This is True" | Should -Match "This is" #Pass
"This is True" | Should -Match "This Is" #Fail

# -Throw - Checks if expression is thrown.
# Note: Input object must be in a scriptblock or else
# it is processed outisde of the assertion!
{ String } | Should -Throw #Pass
{ String } | Should -Not -Throw #Fail
{ $Var = "String" } | Should -Throw #Fail
{ $Var = "String" } | Should -Not -Throw #Pass
{ throw "Error" } | Should -Throw "Error" #Pass
{ throw "Error" } | Should -Not -Throw "Error" #Fail

# -BeNullOrEmpty - Checks values for null or empty
$null | Should -BeNullOrEmpty #Pass
$null | Should -Not -BeNullOrEmpty #Fail
"" | Should -BeNullOrEmpty #Pass
"String" | Should -BeNullOrEmpty #Fail
