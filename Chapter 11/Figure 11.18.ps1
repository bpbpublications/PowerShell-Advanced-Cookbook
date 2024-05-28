# Use the context of the RM user to create a new secret in secret manager
# Requires the AWS.Tools.SecretsManager module

New-SECSecret -Name "TestSecret" -SecretString "VerySecret" -Region eu-north-1

