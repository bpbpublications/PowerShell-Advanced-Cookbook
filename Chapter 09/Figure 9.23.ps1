# Figure 9.23 - Performance: Filter vs Where-Object
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Demonstrates the performance difference between server-side and client-side filtering.

# ============================================================================
# METHOD 1: SERVER-SIDE FILTERING (FASTER)
# ============================================================================

# Using -Filter parameter - filtering happens on the domain controller
(Measure-Command {
    foreach ($i in 0..10000) {
        Get-ADUser -Filter "Country -eq 'DK'"
    }
}).TotalMilliseconds

# ============================================================================
# METHOD 2: CLIENT-SIDE FILTERING (SLOWER)
# ============================================================================

# Using Where-Object - all users retrieved first, then filtered locally
(Measure-Command {
    foreach ($i in 0..10000) {
        Get-ADUser -Filter * | Where-Object { $_.Country -eq "DK" }
    }
}).TotalMilliseconds

# ============================================================================
# WHY -FILTER IS FASTER
# ============================================================================

# -Filter (server-side):
# - Query processed by domain controller
# - Only matching results returned over network
# - Less network traffic, faster execution

# Where-Object (client-side):
# - ALL objects retrieved from domain controller
# - Filtering happens locally in PowerShell
# - More network traffic, slower execution

# BEST PRACTICE: Always use -Filter when possible
