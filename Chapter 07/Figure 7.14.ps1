# Figure 7.14 - Detecting Regressions with Mocked Tests
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates how mocked tests catch bugs when code behavior changes.

# ============================================================================
# MODIFIED FUNCTION WITH CHANGED BEHAVIOR
# ============================================================================

# The function now returns "Website is Up" instead of "Website is running"
# This change breaks backward compatibility

# function Get-WebData {
#     $Response = Invoke-WebRequest -Uri "Bio-Rent.dk"
#
#     if ($Response.StatusCode -eq 200) {
#         return "Website is Up"   # <-- CHANGED from "Website is running"
#     }
#     else {
#         $Status = Restart-WebServer
#         return $Status
#     }
# }

# function Restart-WebServer {
#     try {
#         Stop-Service -Name "W3SVC" -Force
#         Start-Sleep -Seconds 30
#         Start-Service -Name "W3SVC"
#         return "Webserver Restarted"
#     }
#     catch {
#         return "Could not restart webserver"
#     }
# }

# ============================================================================
# PESTER TESTS (UNCHANGED FROM BEFORE)
# ============================================================================

# The tests still expect "Website is running" - this will now FAIL

# BeforeAll {
#     . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
# }

# Describe "Get-WebData Function" {
#     BeforeAll {
#         Mock Restart-WebServer { return "Webserver Restarted" }
#     }
#     Context "Tests: Website is running" {
#         BeforeAll {
#             Mock Invoke-WebRequest {
#                 [PSCustomObject]@{ StatusCode = 200 }
#             }
#         }
#         It "Website should be Running" {
#             $WebData = Get-WebData
#             $WebData | Should -Be "Website is running"  # Expected old value
#         }
#     }
#     Context "Tests: Website is down" {
#         BeforeAll {
#             Mock Invoke-WebRequest {
#                 [PSCustomObject]@{ StatusCode = 503 }
#             }
#         }
#         It "Webserver should have been restarted" {
#             $WebData = Get-WebData
#             $WebData | Should -Be "Webserver Restarted"
#         }
#     }
# }

# ============================================================================
# RUN THE TESTS
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

Invoke-Pester -Configuration $PesterConfig

# Expected Output (test failure):
# Describing Get-WebData Function
#   Context Tests: Website is running
#     [-] Website should be Running
#       Expected strings to be the same, but they were different.
#       Expected: 'Website is running'
#       But was:  'Website is Up'
#   Context Tests: Website is down
#     [+] Webserver should have been restarted
# Tests Passed: 1, Failed: 1, Skipped: 0

# The failed test alerts you to the API change
# You must then decide: fix the code or update the test
