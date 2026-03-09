# Figure 6.22 - List WinRM Listeners (Verification)
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only
# Verifies WinRM listener configuration after modifications.

# ============================================================================
# VIEW WINRM LISTENERS
# ============================================================================

# This is typically run after configuring HTTPS listener
# to verify the new listener is active
Get-ChildItem WSMan:\localhost\Listener\

# Expected Output (after HTTPS configuration):
# Name                      Type
# ----                      ----
# Listener_1124534567       Container    (HTTPS listener)

# After removing HTTP listener and adding HTTPS:
# - Only HTTPS listener should be present
# - HTTP listener (port 5985) should be removed
# - HTTPS listener (port 5986) should be active

# To verify listener details:
# Get-ChildItem WSMan:\localhost\Listener\ | ForEach-Object {
#     Write-Host "Listener: $($_.Name)" -ForegroundColor Cyan
#     Get-ChildItem $_.PSPath | Format-Table Name, Value
# }

# Expected detailed output for HTTPS listener:
# Name                      Value
# ----                      -----
# Address                   *
# Transport                 HTTPS
# Port                      5986
# Hostname                  ps-host01
# Enabled                   true
# CertificateThumbprint     ABC123...
