# Figure 15.17 - Service Executable Command Line
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows
# Prerequisites: Service executable built with PowerShell Studio
#
# This figure shows the command-line options for service executables.
#
# ============================================================================
# SERVICE EXECUTABLE COMMAND LINE OPTIONS
# ============================================================================
#
# Service executables built with PowerShell Studio support these arguments:
#
# ┌─────────────────────────────────────────────────────────────────────────┐
# │ Command Line Usage                                                       │
# ├─────────────────────────────────────────────────────────────────────────┤
# │                                                                          │
# │ ServiceName.exe [options]                                               │
# │                                                                          │
# │ Options:                                                                 │
# │   -install      Install the service                                     │
# │   -uninstall    Uninstall the service                                   │
# │   -start        Start the service (after installation)                  │
# │   -stop         Stop the service                                        │
# │   -status       Show current service status                             │
# │   -debug        Run in console mode for debugging                       │
# │   -help         Show help information                                   │
# │                                                                          │
# └─────────────────────────────────────────────────────────────────────────┘
#
# Examples:
# .\WeatherLogService.exe -install    # Register service with Windows
# .\WeatherLogService.exe -start      # Start the service
# .\WeatherLogService.exe -debug      # Run interactively for testing
# .\WeatherLogService.exe -uninstall  # Remove service registration
#
# Note: Installation and uninstallation require Administrator privileges

# No executable code - this is a screenshot figure

