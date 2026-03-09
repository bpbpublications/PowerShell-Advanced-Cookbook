# Figure 5.15 - Unsigned Script Example
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This is a simple script that needs to be signed before it can run
# when the execution policy is set to AllSigned or RemoteSigned.

# ============================================================================
# SCRIPT CONTENT
# ============================================================================

# Simple output for demonstration
Write-Output "I need to sign this script!"

# ============================================================================
# SIGNING THIS SCRIPT
# ============================================================================

# To sign this script, you need:
# 1. A code signing certificate (see Figure 5.12)
# 2. The Set-AuthenticodeSignature cmdlet
#
# Example:
# $Cert = Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert | Select-Object -First 1
# Set-AuthenticodeSignature -FilePath ".\Figure 5.15.ps1" -Certificate $Cert

# ============================================================================
# EXECUTION POLICY BEHAVIOR
# ============================================================================

# UNRESTRICTED: Runs without signing
# REMOTESIGNED: Runs locally without signing (downloads need signing)
# ALLSIGNED: Requires signature to run
# RESTRICTED: Blocks all scripts

# When execution policy blocks this script:
# .\Figure 5.15.ps1 : File cannot be loaded. The file is not digitally signed.
# You cannot run this script on the current system.

# ============================================================================
# EXPECTED OUTPUT (when allowed to run)
# ============================================================================

# I need to sign this script!

