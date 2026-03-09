# Figure 13.14 - DSC Auto-Correct Demonstration
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: SimpleDsc configuration applied, LCM set to ApplyAndAutoCorrect

# ============================================================================
# DEMONSTRATE DSC AUTO-CORRECTION FEATURE
# ============================================================================

# When the LCM is set to "ApplyAndAutoCorrect" mode, it automatically
# restores resources to their desired state if they are manually changed

# Step 1: View the current registry value (created by DSC)
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Expected Output:
# DSCNODE      : DSCHOST01
# PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\DSC

# ============================================================================
# MANUALLY REMOVE THE REGISTRY VALUE
# ============================================================================

# Step 2: Remove the registry value manually
Remove-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Step 3: Verify the value is gone
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Expected Output:
# Get-ItemProperty : Property DSCNODE does not exist at path HKLM:\SOFTWARE\DSC
# (Error because the value was removed)

# ============================================================================
# WAIT FOR LCM TO AUTO-CORRECT
# ============================================================================

# Step 4: Wait for the LCM consistency check (based on ConfigurationModeFrequencyMins)
# Or trigger it manually: Update-DscConfiguration -Wait

# Step 5: Check again after LCM runs
Get-ItemProperty -Path "HKLM:\SOFTWARE\DSC" -Name DSCNODE

# Expected Output (after LCM auto-corrects):
# DSCNODE      : DSCHOST01
# PSPath       : Microsoft.PowerShell.Core\Registry::HKEY_LOCAL_MACHINE\SOFTWARE\DSC
#
# NOTE: The LCM automatically restored the registry value to its desired state
# This demonstrates the "self-healing" capability of DSC

