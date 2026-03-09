# Figure 3.12 - While loop for password validation with retry logic
# Chapter 3: Flow Control and Looping
# PowerShell Advanced Cookbook - BPB Publications

# This example demonstrates the while loop for implementing retry logic.
# Compare this with Figure 3.11 to understand the difference between
# while (condition checked first) and do-while (condition checked after).

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
# WHILE LOOP FOR PASSWORD VALIDATION
# ============================================================================

$Attempts = 0
$Success = $false

# while checks the condition BEFORE each iteration
# Loop continues as long as attempts are under the limit
while ($Attempts -lt 3) {
    # Prompt user for password
    $UserPassword = Read-Host -Prompt "Enter password"

    # Check if password matches any in the database
    if ($UserPassword -in $PasswordDatabase) {
        $Success = $true
        break  # Exit loop - correct password entered
    }
    else {
        Write-Output "Wrong password. Retry."
        $Attempts++  # Increment counter on failed attempt
    }
}

# Check final status after loop exits
if ($Success) {
    Write-Output "Password accepted. Access granted."
}
else {
    Write-Output "Too many attempts. Access denied"
}

# ============================================================================
# KEY CONCEPTS DEMONSTRATED
# ============================================================================
# - 'while' checks condition BEFORE entering the loop
# - If $Attempts started at 3, the loop would never execute
# - The condition uses -in for positive array membership test
# - 'break' provides early exit on successful password
# - Counter is only incremented on failed attempts
# - More explicit success/failure handling compared to do-while

# Expected Output (successful login):
# Enter password: wrongpass
# Wrong password. Retry.
# Enter password: Passw0rd!
# Password accepted. Access granted.

# Expected Output (failed login):
# Enter password: wrong1
# Wrong password. Retry.
# Enter password: wrong2
# Wrong password. Retry.
# Enter password: wrong3
# Wrong password. Retry.
# Too many attempts. Access denied

# ============================================================================
# WHILE VS DO-WHILE COMPARISON
# ============================================================================
# while:    Condition checked BEFORE loop body - may never execute
# do-while: Condition checked AFTER loop body - always executes at least once
#
# Use 'while' when: You want to skip entirely if condition is already false
# Use 'do-while' when: You need at least one execution (like prompting user)
