# Recipe: Managing PowerShell Execution Policies
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to view and modify PowerShell's execution policy,
# which controls whether scripts are allowed to run.
#
# Platform: Windows (on Linux/macOS, execution policy has limited effect)

# ============================================================================
# VIEW CURRENT EXECUTION POLICY
# ============================================================================

# Get the current execution policy for the session
Get-ExecutionPolicy

# Get a list of execution policies for all scopes
Get-ExecutionPolicy -List

# Get execution policy for a specific scope
Get-ExecutionPolicy -Scope Process

# ============================================================================
# EXPECTED OUTPUT
# ============================================================================

# Get-ExecutionPolicy
# RemoteSigned

# Get-ExecutionPolicy -List
#         Scope ExecutionPolicy
#         ----- ----------------
# MachinePolicy       Undefined
#    UserPolicy       Undefined
#       Process       Undefined
#   CurrentUser    RemoteSigned
#  LocalMachine       Undefined

# ============================================================================
# SET EXECUTION POLICY
# ============================================================================

# Set the execution policy (requires elevation for LocalMachine scope)
Set-ExecutionPolicy -ExecutionPolicy AllSigned

# Set the execution policy for a specific scope
# Process scope only affects the current PowerShell session
Set-ExecutionPolicy -ExecutionPolicy AllSigned -Scope Process

# ============================================================================
# REMOVE EXECUTION POLICY
# ============================================================================

# Remove the execution policy (set as undefined)
Set-ExecutionPolicy -ExecutionPolicy Undefined

# Remove the execution policy for a specific scope
Set-ExecutionPolicy -ExecutionPolicy Undefined -Scope Process

# ============================================================================
# EXECUTION POLICY VALUES
# ============================================================================

# RESTRICTED (Windows default):
# - No scripts can run
# - Interactive commands only

# ALLSIGNED:
# - Only scripts signed by trusted publishers can run
# - Prompts for untrusted publishers

# REMOTESIGNED (Recommended):
# - Local scripts run without signature
# - Downloaded scripts must be signed

# UNRESTRICTED:
# - All scripts can run
# - Prompts for downloaded scripts

# BYPASS:
# - No restrictions, no warnings
# - Use for automation where safety is controlled elsewhere

# UNDEFINED:
# - No policy set at this scope
# - Inherits from higher scope

# ============================================================================
# SCOPE PRECEDENCE (highest to lowest)
# ============================================================================

# 1. MachinePolicy - Set by Group Policy (computer)
# 2. UserPolicy    - Set by Group Policy (user)
# 3. Process       - Current PowerShell session only
# 4. CurrentUser   - Current user only
# 5. LocalMachine  - All users on this computer

# Note: Group Policy scopes cannot be changed locally

# ============================================================================
# COMMON PATTERNS
# ============================================================================

# Bypass for a single command (useful in scripts):
# PowerShell -ExecutionPolicy Bypass -File ".\script.ps1"

# Set for current user (no elevation required):
# Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Check if policy allows script execution:
# $policy = Get-ExecutionPolicy
# if ($policy -eq "Restricted") {
#     Write-Warning "Scripts are blocked. Change execution policy."
# }

