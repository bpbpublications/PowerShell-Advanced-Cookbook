# Figure 6.14 - Export Credentials to Encrypted XML
# Chapter 6: PowerShell Remoting
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (encryption tied to user/machine)
# Demonstrates securely storing credentials in an encrypted XML file.

# ============================================================================
# CAPTURE AND EXPORT CREDENTIALS
# ============================================================================

# Get-Credential prompts for username and password
# Creates a PSCredential object with encrypted password
$Credential = Get-Credential

# Export-Clixml serializes the credential to an encrypted XML file
# The encryption uses Windows Data Protection API (DPAPI)
# ONLY the same user on the same computer can decrypt it
$Credential | Export-Clixml -Path C:\Temp\Encrypted.xml

# ============================================================================
# VIEW ENCRYPTED FILE CONTENTS
# ============================================================================

# The XML file contains encrypted data - password cannot be read directly
Get-Content C:\Temp\Encrypted.xml

# Expected Output (encrypted SecureString is not human-readable):
# <Objs Version="1.1.0.1" ...>
#   <Obj RefId="0">
#     <TN RefId="0">
#       <T>System.Management.Automation.PSCredential</T>
#       ...
#     </TN>
#     <Props>
#       <S N="UserName">DOMAIN\Username</S>
#       <SS N="Password">01000000d08c9ddf0115d1118c7a00c04fc297eb...</SS>
#     </Props>
#   </Obj>
# </Objs>

# Security Notes:
# - Encryption is tied to the current user AND computer
# - File cannot be decrypted by different users or on different machines
# - Store the file securely (ACLs, not in source control)
# - Consider using a proper secrets manager for production
