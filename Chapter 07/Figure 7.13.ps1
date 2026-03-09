# Figure 7.13 - Mocking External Dependencies
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (PowerShell 5.1+ and PowerShell 7+)
# Demonstrates using Pester mocks to isolate tests from external dependencies.

# ============================================================================
# FUNCTIONS UNDER TEST
# ============================================================================

# Get-WebData checks a website and restarts it if needed
# It depends on Invoke-WebRequest (external HTTP call) and Restart-WebServer

# function Get-WebData {
#     $Response = Invoke-WebRequest -Uri "Bio-Rent.dk"
#
#     if ($Response.StatusCode -eq 200) {
#         return "Website is running"
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
# PESTER TESTS WITH MOCKS
# ============================================================================

# Mocks replace real cmdlets/functions with controlled behavior
# This allows testing without making actual HTTP calls or restarting services

# BeforeAll {
#     . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
# }

# Describe "Get-WebData Function" {
#     BeforeAll {
#         # Mock Restart-WebServer to return predictable value
#         Mock Restart-WebServer { return "Webserver Restarted" }
#     }
#
#     Context "Tests: Website is running" {
#         BeforeAll {
#             # Mock Invoke-WebRequest to simulate successful response
#             Mock Invoke-WebRequest {
#                 [PSCustomObject]@{
#                     StatusCode = 200
#                 }
#             }
#         }
#         It "Website should be Running" {
#             $WebData = Get-WebData
#             $WebData | Should -Be "Website is running"
#         }
#     }
#
#     Context "Tests: Website is down" {
#         BeforeAll {
#             # Mock Invoke-WebRequest to simulate server error
#             Mock Invoke-WebRequest {
#                 [PSCustomObject]@{
#                     StatusCode = 503
#                 }
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

# Expected Output:
# Describing Get-WebData Function
#   Context Tests: Website is running
#     [+] Website should be Running
#   Context Tests: Website is down
#     [+] Webserver should have been restarted
# Tests Passed: 2, Failed: 0, Skipped: 0

# Benefits of mocking:
# - No actual HTTP requests are made
# - No services are stopped/started
# - Tests run quickly and reliably
# - Tests are isolated from network/system state
