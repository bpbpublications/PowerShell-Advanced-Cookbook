# Figure 15.6 - PowerShell Studio Project Files Structure
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This figure shows the project file structure in PowerShell Studio.
#
# ============================================================================
# PROJECT FILE STRUCTURE
# ============================================================================
#
# PowerShell Studio organizes projects with specific file types:
#
# ProjectName/
# ├── ProjectName.psf          # Project file (XML format)
# │                             # Contains project settings and references
# │
# ├── ProjectName.psf.psbuild  # Build configuration
# │                             # Defines how to compile/package the project
# │
# ├── Startup.pss              # Startup script segment
# │                             # Runs before form is displayed
# │
# ├── Globals.ps1              # Global variables and functions
# │                             # Shared across all forms
# │
# ├── MainForm.psf             # Main form definition
# │                             # Contains form layout and properties
# │
# ├── MainForm.designer.ps1    # Form designer code (auto-generated)
# │                             # DO NOT edit manually
# │
# └── MainForm.ps1             # Form event handlers
#                               # Your custom code goes here
#
# File Extensions:
# .psf     - PowerShell Studio Form/Project
# .pss     - PowerShell Script Segment
# .ps1     - PowerShell Script
# .psbuild - Build Configuration

# No executable code - this is a screenshot figure

