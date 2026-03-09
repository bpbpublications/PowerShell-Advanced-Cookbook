# Figure 11.21 - SSH Connection to EC2 Linux Instance
# Chapter 11: AWS PowerShell Tools
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Cross-platform (requires SSH client)
# Prerequisites: EC2 instance running, security group allows port 22, private key file

# ============================================================================
# CONNECT TO LINUX EC2 INSTANCE VIA SSH
# ============================================================================

# You need to have followed the recipe and set up an instance for SSH access
# The security group must allow inbound traffic on port 22 from your IP

# Connect to a Linux instance using SSH
# Syntax: ssh -i <PathToPrivateKey.pem> username@<PublicIP>

# Generic example:
ssh -i <PathToPrivateKey.pem file> ubuntu@<PublicIpForEC2Instance>

# Specific example with actual paths:
ssh -i C:\Temp\SSHKey.pem ubuntu@123.10.10.123

# Expected Output:
# The authenticity of host '123.10.10.123 (123.10.10.123)' can't be established.
# ED25519 key fingerprint is SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.
# Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
# Warning: Permanently added '123.10.10.123' (ED25519) to the list of known hosts.
# Welcome to Ubuntu 22.04.3 LTS (GNU/Linux 5.15.0-1049-aws x86_64)
# ubuntu@ip-172-31-xx-xx:~$
#
# NOTE: For Amazon Linux AMIs, use 'ec2-user' instead of 'ubuntu'
# Ensure the .pem file has restricted permissions (chmod 400 on Linux/Mac)
