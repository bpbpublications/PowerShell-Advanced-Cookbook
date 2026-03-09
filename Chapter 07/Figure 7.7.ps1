# Figure 7.7 - Use Pester Configuration from File
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates loading Pester configuration from a separate file.

# ============================================================================
# CONFIGURATION FILE APPROACH
# ============================================================================

# Configuration can be stored in a separate .ps1 file for reusability
# This allows consistent test settings across multiple test runs

# Create a Pester configuration in the current script
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# ============================================================================
# LOAD CONFIGURATION FROM EXTERNAL FILE
# ============================================================================

# Dot-source the configuration file to load the $PesterConfig variable
# The path must point to the configuration file
. ..\PesterConfigs\PesterConfig-Detailed.ps1

# The configuration file (PesterConfig-Detailed.ps1) might contain:
# $PesterConfig = New-PesterConfiguration
# $PesterConfig.Output.Verbosity = "Detailed"
# $PesterConfig.CodeCoverage.Enabled = $true
# $PesterConfig.Run.Exit = $true

# ============================================================================
# RUN TESTS WITH CONFIGURATION
# ============================================================================

# Invoke Pester using the loaded configuration
Invoke-Pester -Configuration $PesterConfig

# Expected Output:
# Starting discovery in 1 files.
# Discovery found X tests in XXms.
# Running tests.
# Describing Test Suite Name
#   Context Test Context
#     [+] Test case 1 XXms (XXms|XXms)
#     [+] Test case 2 XXms (XXms|XXms)
# Tests completed in XXXms
# Tests Passed: X, Failed: 0, Skipped: 0

# ============================================================================
# BENEFITS OF EXTERNAL CONFIGURATION
# ============================================================================

# 1. Reusable across multiple test files
# 2. Easy to switch between configurations (dev, CI, verbose)
# 3. Keeps test files clean and focused on tests
# 4. Supports different environments with different settings
