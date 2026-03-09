# Figure 9.32 - Run Bulk User Creation Script
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates running the CreateBulkADUsers.ps1 script.

# ============================================================================
# RUN BULK USER CREATION
# ============================================================================

# Execute the bulk user creation script with CSV file path
.\CreateBulkADUsers.ps1 -CsvFilePath .\BulkUsers.csv -Verbose

# Expected Output (with -Verbose):
# VERBOSE: Created user for: Olivia Smith
# VERBOSE: Created user for: William Brown
# VERBOSE: Created user for: James Wilson
# ...

# ============================================================================
# WHAT THE SCRIPT DOES
# ============================================================================

# For each row in the CSV file:
# 1. Reads user data from CSV
# 2. Calls CreateADUser.ps1 with the parameters
# 3. CreateADUser.ps1 generates username and password
# 4. Creates the AD user account
# 5. Adds user to country-specific group
# 6. Creates password file for the user

# ============================================================================
# POST-CREATION TASKS
# ============================================================================

# After bulk creation, you may need to:
# - Distribute passwords securely to users
# - Verify all users were created successfully
# - Configure additional permissions or mailboxes
# - Clean up password files after distribution
