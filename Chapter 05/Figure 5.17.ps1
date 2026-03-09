# Figure 5.17 - Signed Script Example
# Chapter 5: Working with Scripts
# PowerShell Advanced Cookbook - BPB Publications
#
# This script has been digitally signed with a code signing certificate.
# Note: The signature is only valid on the system where it was created.
#
# Platform: Windows only

# ============================================================================
# SCRIPT CONTENT
# ============================================================================

Write-Output "I need to sign this script!"

# ============================================================================
# SIGNATURE VERIFICATION
# ============================================================================

# To verify this script's signature:
# Get-AuthenticodeSignature -FilePath ".\Figure 5.17.ps1"
#
# Expected output on original system: Status = Valid
# Expected output on other systems: Status = UnknownError
# (because the self-signed certificate is not trusted)

# ============================================================================
# SIGNATURE BLOCK BELOW
# ============================================================================

# The signature block is automatically appended by Set-AuthenticodeSignature
# It contains:
# - The digital signature (encrypted hash)
# - Certificate information
# - Signing timestamp
#
# IMPORTANT: Any modification to the script above this line
# will invalidate the signature!

# SIG # Begin signature block
# MIIIogYJKoZIhvcNAQcCoIIIkzCCCI8CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDIM/rFiHIaeAdn
# i4JDnDENV8wlGC0aXcVz/58PU0WsaqCCBRwwggUYMIIDAKADAgECAhBLMRl+OcGh
# nEKqERDE/gpDMA0GCSqGSIb3DQEBBQUAMBYxFDASBgNVBAMMC0NvZGVzaWduaW5n
# MB4XDTIzMDgxMzEyNTAxMVoXDTI0MDgxMzEzMTAxMVowFjEUMBIGA1UEAwwLQ29k
# ZXNpZ25pbmcwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCosSmXr7hH
# l1HEUcdDvhk9uCzgItn6lj/QQHtThAUMoghwDEq4g4Paai4JzkO4kkeFrK++Ofzl
# yZ7GIJJ4NEA9hMKqOr2RVA+WOiUMo78qLf+mgbmI3udhqMIyzwCmq3VoWfrHhb1i
# 7Y8Wa5FjEug9JX3540J4nFbodx3jw9NR44bQnks/93I5Faf9kyNjNPa0pEro4OJm
# fpcuApSkW1TQZ1eP0jS0/n/xzmzl0eyXYbJlOgZKciDMPG8og6sqUdzCGce7kfuP
# WsF3Uw8PlcaQO8gm1Gh7ej59FWPOjCEKoUG+nBKZ4ad/qgYqzJLc7JHzpklCTs12
# 9Wje/V6Xxbvy7M/eOVe2y+kNgpJwGDfqqPMo0eazsmqjqErz4a+S/u85/wUlglo7
# JqHj4P5iW7tALXFzLuvspHquP2XUfdGMIb81g/iPPlwrbQQcb63utLnYPqtuiBKz
# a6ypQ9+t63Rs3201mn4sR7/NM3QO5qHf/9Pz2ReZDOGDcrsmYB1CDkvwPhTzJn2S
# s9Ni9sDqG0Pd3QeHnHya26pIS6xK1up+dgrjxh5hx6kz/UBnNyBlxpIp6LnZdOyu
# vb1qiEUcPrcJWxyXAwMmYOhXiRf3q8Y2J0K3/74sIFhwjSFt29nxA8kxfU3diynC
# aZNfY8Om9SFPlFxGt9Xq27z2yKnAZESk1QIDAQABo2IwYDAOBgNVHQ8BAf8EBAMC
# B4AwEwYDVR0lBAwwCgYIKwYBBQUHAwMwGgYDVR0RBBMwEYIPd3d3Lm1vcHBsZWl0
# LmRrMB0GA1UdDgQWBBRzpkO3dZWXchAUKHejbGVyo7g7hTANBgkqhkiG9w0BAQUF
# AAOCAgEApwIvauivo4XgvzEOqyn4TLm26+hCnCBEfydX+ON9U62YPbnsQxkqTpGM
# BRU+tqhsiJpsb17zc7UeURcoeyDmTB67UghbcgD6IDe9EznA6bylJMq2Mq/ChWDb
# JmhWCqawA482GajvNiDzA5G7XK8p/k0pMJjC7FdjCSsvSI+6mmQbAqSjgCLTaoI3
# qHKOVX0HJguzHE9LxfNCSmHXPBI3eWTrmCbNVbC1UhkhKEM4Tqp6ZX/46zVFIlN9
# P2A6WTa7H5cQAS1pS9Dj9pjHuXDRGoIlVp3HTVCZbIdKqjN6AQqboPh5azAr3iTA
# Oedm2nQ7f5HKJtwygHW0XtJQwSB7GTEsLTOCvtfOCbRdA6e9RLDgJWOaAtVidIQ5
# m4QmeZ1EUrIu0I7AmE4pLPLqTTerVV8FLhZpzs+oCoQ017Y1R8K+0ifgGhdUEZT9
# chRUGxI2hKBa68am1J8dFk1kihvTULvHBfTEQMX+hgJ2NVZLQnrtM10MyMeBrE0R
# XWV+PL+fUqIOcvWmn6b3Ozm+yKG6HPeraTxywJ5qnuLxB5shOZSgkqFI61EXiQdH
# kNqVsrJboLK2qNayNK2e04cb6N7JD3MfgBtZLEEXnGUCGTj7kVLJg9aAzqjNAhVm
# bobQNhyL5dwI4WYfttIEQccyfBtEceIv+1W3vS2RYS+sm66c5UgxggLcMIIC2AIB
# ATAqMBYxFDASBgNVBAMMC0NvZGVzaWduaW5nAhBLMRl+OcGhnEKqERDE/gpDMA0G
# CWCGSAFlAwQCAQUAoIGEMBgGCisGAQQBgjcCAQwxCjAIoAKAAKECgAAwGQYJKoZI
# hvcNAQkDMQwGCisGAQQBgjcCAQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcC
# ARUwLwYJKoZIhvcNAQkEMSIEIEO6sN69WPL/GvipYExoec/wN1AyQoUw2368+OE2
# bSOxMA0GCSqGSIb3DQEBAQUABIICAIpq7gYGTklVcK7fQL+BbNoneWCsQcZYuWdn
# IlGLkE8qPzidepNhU92QoYI9Ri6a24i1Oz4oib7Ji866uGpquj1lNCCdDAkbV2dG
# I/S3qTKYDKQ1Lv3n+EyjU+wgvP7+q/jJVNUE47fPj8lPZpncfBxP+UYOtNtuudKS
# Yn7hNWoOWmbGy0u5Sgs3z05IQJJvyzVF/Fb/XPrmD4OBHyDm2DgjtzPffGOiQSsh
# 24QSkJw99Hx2WVva0WJMK6s3IDr1sMCO0XfGmmSeA+V3bE4++5TJM6cCgMX7h2dO
# CQoo+7X5hXb0XSj00MplvZ9TWzBPHNd00gCBZC77285ju1qiJuqfy6BPrBcw1UrT
# ISfTQIZXph2DL2b3ftBhLakAfLX9uNN6OrnDyN438klLSclgUPV18ebjJoBnctcH
# ZE2NGucgP65Mkd27DUGD2NqDYs0hMgelhsi0H/HCMssmeERP4zHZxK4odzhFEAJb
# A8o0FT6fLSrx5SukrdQvJswAsF0uBQIIGUp6oewChv6u02OcCpEePwA7Ufw0EdhQ
# W8Ucn/knjbrQ5zlswihIC53J05EI21CjRnioUw1Hnf10ESPLfmnXR7N4VKuko7zd
# ZmdGgAKtWfL9u0zZ1HD2iw2mRoz/78GvNUyWFSCH6nps6tsggtx2qNLksZhV4MYA
# qWSFYSu+
# SIG # End signature block
