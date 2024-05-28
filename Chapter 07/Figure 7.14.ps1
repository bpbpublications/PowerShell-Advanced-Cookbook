# Get-WebData function with changed behavior (Changed -Running to -Up)

# function Get-WebData {
#     $Response = Invoke-WebRequest -Uri "Bio-Rent.dk"
    
#     if ($Response.StatusCode -eq 200){
#         return "Website is Up"
#     }
#     else{
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

# Get-WebData function test cases with MOCKS
# BeforeAll {
#     . $PSCommandPath.Replace('.Tests.ps1', '.ps1')
# }

# Describe "Get-WebData Function" {
#     BeforeAll {
#         Mock Restart-WebServer {return "Webserver Restarted"}
#     }
#     Context "Tests: Website is running" {
#         BeforeAll {
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
#     Context "Tests: Website is down" {
#         BeforeAll {
#             Mock Invoke-WebRequest {
#                 [PSCustomObject]@{
#                     StatusCode = 503
#                 }
#             }
#         }
#         It "Webserver should have been restarted" {
#             $WebData = Get-WebData
#             $WebData | Should -be "Webserver Restarted"
#         }
#     }
# }


# Create a Pester configuration. 
$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Invoke Pester using the configuration
Invoke-Pester -Configuration $PesterConfig