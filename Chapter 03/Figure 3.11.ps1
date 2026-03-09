# Figure 3.11 - Do-While loop for password validation with retry logic
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates the do-while loop for implementing retry logic.
# The do-while loop is ideal when you need to execute code at least once
# before checking the condition (e.g., prompt for input, then validate).

# ============================================================================
# PASSWORD DATABASE (FOR DEMONSTRATION ONLY)
# ============================================================================

# WARNING: Never store passwords in plain text in production code!
# This is for educational purposes only to demonstrate loop logic.
$PasswordDatabase = @(
    "Passw0rd!",
    "S3cur3P@ss",
    "P@ssw0rd123",
    "MyP@ssw0rd",
    "SuperSecret!",
    "12345Password",
    "P@55word!",
    "Secret123$",
    "P@ssw0rd!",
    "P@ssword2023"
)

# ============================================================================
# DO-WHILE LOOP FOR PASSWORD VALIDATION
# ============================================================================

$Attempts = 0
$Success = $null

# do-while executes the block FIRST, then checks the condition
# This guarantees at least one password prompt
do {
    # Check if we've exceeded maximum attempts
    if ($Attempts -lt 3) {
        # Prompt user for password (this runs at least once)
        $UserPassword = Read-Host -Prompt "Enter password"
    }
    else {
        # Maximum attempts reached - deny access and exit loop
        Write-Output "Too many attempts. Access denied"
        $Success = $false
        break  # Exit the loop immediately
    }

    # Increment attempt counter after each try
    $Attempts++

# Continue looping while password is NOT in the database
} while ($UserPassword -notin $PasswordDatabase)

# Check final status - if we didn't explicitly fail, we succeeded
if ($Success -ne $false) {
    Write-Output "Password accepted. Access granted."
}

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - do-while executes the loop body BEFORE checking the condition
# - Ideal for "prompt then validate" patterns
# - The condition uses -notin to check array membership
# - 'break' exits the loop when max attempts exceeded
# - Compare with Figure 3.12 which uses 'while' for similar logic

# Expected Output (successful login):
# Enter password: wrongpass
# Enter password: wrongpass2
# Enter password: Passw0rd!
# Password accepted. Access granted.

# Expected Output (failed login):
# Enter password: wrong1
# Enter password: wrong2
# Enter password: wrong3
# Too many attempts. Access denied
