# Recipe: Pester Configuration Examples
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates various Pester configuration options.

# ============================================================================
# CREATE BASE CONFIGURATION
# ============================================================================

# Create a new Pester configuration object with defaults
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# ============================================================================
# FILTER BY SINGLE TAG
# ============================================================================

# Run only tests with the "Windows" tag
$PesterConfig.Filter.Tag = "Windows"

# ============================================================================
# FILTER BY MULTIPLE TAGS
# ============================================================================

# Run tests with either "Linux" or "MacOS" tags
$PesterConfig.Filter.Tag = "Linux", "MacOS"

# ============================================================================
# ENABLE CODE COVERAGE
# ============================================================================

# Uncomment to enable code coverage analysis
# $PesterConfig.CodeCoverage.Enabled = $true

# ============================================================================
# ENABLE TEST RESULT OUTPUT
# ============================================================================

# Uncomment to output test results to file
# $PesterConfig.TestResult.Enabled = $true
# $PesterConfig.TestResult.OutputPath = "TestResults.xml"

# ============================================================================
# FILTER BY DESCRIBE BLOCK NAMES
# ============================================================================

# Run only specific Describe blocks by exact name
$Groups = @(
    "Linux Tests - Platform independent"
    "Windows Tests - Platform independent"
    "MacOS Tests - Platform independent"
)
$PesterConfig.Filter.FullName = $Groups

# ============================================================================
# FILTER BY WILDCARD PATTERN
# ============================================================================

# Use wildcard to match multiple Describe block names
# This matches all blocks ending with "independent"
$PesterConfig.Filter.FullName = "* independent"

# ============================================================================
# OTHER USEFUL OPTIONS
# ============================================================================

# Set test path:
# $PesterConfig.Run.Path = ".\Tests"

# Exit with non-zero code on failure (for CI/CD):
# $PesterConfig.Run.Exit = $true

# Skip specific tests:
# $PesterConfig.Run.SkipRun = $true

# Pass specific parameters to tests:
# $PesterConfig.Run.PassThru = $true

# ============================================================================
# USAGE
# ============================================================================

# To use this configuration file:
# 1. Dot-source it: . .\PesterConfig.ps1
# 2. Run tests: Invoke-Pester -Configuration $PesterConfig
