# Figure 15.10 - Service Build Output
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This figure shows the build output for a Windows Service project.
#
# ============================================================================
# SERVICE BUILD OUTPUT
# ============================================================================
#
# When building a Service project, PowerShell Studio generates:
#
# OutputFolder/
# ├── bin/
# │   ├── x64/
# │   │   └── ServiceName.exe    # 64-bit service executable
# │   └── x86/
# │       └── ServiceName.exe    # 32-bit service executable
# │
# ├── ServiceName.msi            # MSI installer package
# │
# └── ServiceName.ps1            # Source PowerShell script
#
# Build Output Console:
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Building WeatherLogService...                                           │
# │ Compiling x64 executable... Done                                        │
# │ Compiling x86 executable... Done                                        │
# │ Creating MSI installer... Done                                          │
# │ Build completed successfully.                                           │
# │                                                                          │
# │ Output: C:\Projects\WeatherLogService\bin\                              │
# └─────────────────────────────────────────────────────────────────────────┘

# No executable code - this is a screenshot figure

