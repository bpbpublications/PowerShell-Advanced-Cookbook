# Figure 4.8 - ErrorActionPreference Inquire
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates "Inquire" which prompts the user to decide
# how to handle each error interactively.

# ============================================================================
# ERRORACTIONPREFERENCE = "INQUIRE"
# ============================================================================

# User is prompted to choose how to handle each error
$ErrorActionPreference = "Inquire"

# This will prompt the user with options
Get-Content -Path "NonExistingFile.txt"

# This line executes based on user's choice
Write-Output "Prompts user for continuation. Shows error. Further execution depends on user answer"

# ============================================================================
# INQUIRE BEHAVIOR
# ============================================================================

# WITH INQUIRE:
# 1. Error message is displayed
# 2. User is prompted with options:
#    [Y] Yes        - Continue with the next statement
#    [A] Yes to All - Continue without prompting again
#    [H] Halt       - Stop the script
#    [S] Suspend    - Pause and enter nested prompt
#    [?] Help       - Show help for these options
# 3. Script behavior depends on user response

# ============================================================================
# WHEN TO USE INQUIRE
# ============================================================================

# GOOD USE CASES:
# - Interactive debugging sessions
# - Scripts where human judgment is needed
# - Learning/exploration (understand each error)
# - Semi-automated processes with human oversight

# BAD USE CASES:
# - Automated/unattended scripts (will hang waiting for input)
# - Scheduled tasks
# - Background jobs
# - CI/CD pipelines

# ============================================================================
# INTERACTIVE PROMPT EXAMPLE
# ============================================================================

# When the error occurs, you'll see:
#
# Get-Content: Cannot find path '...\NonExistingFile.txt' because it does not exist.
#
# Confirm
# Continue with this operation?
# [Y] Yes  [A] Yes to All  [H] Halt Command  [S] Suspend  [?] Help
# (default is "Y"):

# Expected Output:
# (Error message displayed)
# (Interactive prompt shown)
# Prompts user for continuation. Shows error. Further execution depends on user answer
# (If user selects Yes or Yes to All)
