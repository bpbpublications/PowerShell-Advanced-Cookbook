# Figure 7.6 - Create Pester Configuration Object
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates creating and customizing a Pester configuration object.

# ============================================================================
# CREATE PESTER CONFIGURATION
# ============================================================================

# New-PesterConfiguration creates a configuration object with default settings
# This object allows fine-grained control over test execution
$PesterConfig = New-PesterConfiguration

# Set output verbosity to show detailed test results
# Options: None, Normal, Detailed, Diagnostic
$PesterConfig.Output.Verbosity = "Detailed"

# ============================================================================
# EXAMINE CONFIGURATION OBJECT
# ============================================================================

# View the type of the configuration object
$PesterConfig.GetType()

# Expected Output:
# IsPublic IsSerial Name                                     BaseType
# -------- -------- ----                                     --------
# True     False    PesterConfiguration                      System.Object

# View all configuration sections and their current values
$PesterConfig

# Expected Output (partial):
# Run          : PesterRunConfiguration
# Filter       : PesterFilterConfiguration
# CodeCoverage : PesterCodeCoverageConfiguration
# TestResult   : PesterTestResultConfiguration
# Should       : PesterShouldConfiguration
# Debug        : PesterDebugConfiguration
# Output       : PesterOutputConfiguration

# ============================================================================
# COMMON CONFIGURATION OPTIONS
# ============================================================================

# Filter tests by tag:
# $PesterConfig.Filter.Tag = "Unit", "Integration"

# Enable code coverage:
# $PesterConfig.CodeCoverage.Enabled = $true

# Specify test path:
# $PesterConfig.Run.Path = ".\Tests"

# Exit with non-zero code on failure (for CI/CD):
# $PesterConfig.Run.Exit = $true
