# Figure 15.7 - Building and Packaging Applications
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This figure shows the build and packaging options in PowerShell Studio.
#
# ============================================================================
# BUILD AND PACKAGE OPTIONS
# ============================================================================
#
# PowerShell Studio can package scripts into various formats:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Package Options                                                          │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ Output Format:                                                           │
# │ ○ Standalone Executable (.exe)                                          │
# │   - Self-contained, no PowerShell required on target                    │
# │   - Includes all dependencies                                           │
# │                                                                          │
# │ ○ MSI Installer (.msi)                                                  │
# │   - Windows Installer package                                           │
# │   - Supports upgrades and uninstall                                     │
# │                                                                          │
# │ ○ Script Package (.ps1)                                                 │
# │   - Combined script file                                                │
# │   - Requires PowerShell on target                                       │
# │                                                                          │
# │ Options:                                                                 │
# │ [✓] Sign output with certificate                                        │
# │ [✓] Embed dependent modules                                             │
# │ [✓] Include x86 and x64 versions                                        │
# │ [ ] Require administrator privileges                                    │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘

# No executable code - this is a screenshot figure

