# Figure 13.17 - Website Created by DSC
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: WebSite DSC configuration applied to target node

# ============================================================================
# WEBSITE CREATED BY DSC CONFIGURATION
# ============================================================================

# This figure shows the result of applying the WebSite DSC configuration
# (defined in Public-Resource-config.ps1) to a target node.
#
# The configuration:
# 1. Installs the Web-Server Windows feature (IIS)
# 2. Creates the C:\inetpub\wwwroot\mysite directory
# 3. Creates an index.html file with content "<h1>This is MySite</h1>"
# 4. Stops the Default Web Site to free up port 80
# 5. Creates a new IIS website called "MySite" bound to port 80
#
# After applying the configuration, browsing to http://DSCHOST02
# displays the simple HTML page created by DSC.
#
# Browser Output:
# ┌─────────────────────────────────────────────────────────────────────┐
# │                                                                      │
# │   This is MySite                                                     │
# │                                                                      │
# └─────────────────────────────────────────────────────────────────────┘
#
# NOTE: This demonstrates how DSC can be used to:
# - Install Windows features
# - Create directory structures
# - Deploy web content
# - Configure IIS websites
# All in a declarative, idempotent manner

