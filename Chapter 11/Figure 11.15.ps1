# The -AccessKey and -SecretKey should be replaced to match that
# of the new NoConsoleAccess user!

# List all IAM users with the context of the NoConsoleAccess user
Get-IAMUsers -AccessKey AKIA5V67JFUT27ZTTORG `
-SecretKey wmd0daPbp6dsd0UMtmbClYQXsqF5fP7VPcBRzoIN | `
Select-Object UserName,Arn