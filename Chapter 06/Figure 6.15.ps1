# Figure 6.15 - Import Credentials from Encrypted XML
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (must be same user/computer that exported)
# Demonstrates importing stored credentials and extracting the password.

# ============================================================================
# IMPORT ENCRYPTED CREDENTIALS
# ============================================================================

# Import-Clixml deserializes the credential from the encrypted XML file
# Decryption happens automatically using DPAPI
# ONLY works for the same user on the same computer that created the file
$Credential = Import-Clixml -Path C:\Temp\Encrypted.xml

# Display the credential object (password remains secure)
$Credential

# Expected Output:
# UserName                     Password
# --------                     --------
# DOMAIN\Username              System.Security.SecureString

# Use the credential for remoting:
# New-PSSession -ComputerName "PS-HOST01" -Credential $Credential

# ============================================================================
# EXTRACT PLAIN TEXT PASSWORD (USE WITH CAUTION)
# ============================================================================

# NetworkCredential can extract the plain text password from SecureString
# This is useful for APIs that require plain text passwords
# WARNING: This exposes the password in memory
$ConnString = [System.Net.NetworkCredential]::new("", $Credential.Password).Password
$ConnString

# Expected Output: The plain text password (e.g., MyPassword)

# Alternative method using SecureString marshal:
# $BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($Credential.Password)
# $PlainPassword = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

# Security Note: Avoid extracting plain text passwords when possible
# Use the credential object directly with cmdlets that support it
