# Figure 14.10 - Start and Monitor Processes
# Chapter 14: System Administration with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (Notepad is Windows-specific)
# Prerequisites: None

# ============================================================================
# CHECK FOR EXISTING NOTEPAD PROCESSES
# ============================================================================

# Get any currently running Notepad processes
Get-Process -Name "Notepad"

# Expected Output (if no Notepad running):
# Get-Process: Cannot find a process with the name "Notepad"...

# ============================================================================
# START A NEW PROCESS
# ============================================================================

# Start-Process launches a new process
# -FilePath specifies the executable to run
Start-Process -FilePath Notepad

# ============================================================================
# VERIFY THE PROCESS IS RUNNING
# ============================================================================

# Get the newly started Notepad process
Get-Process -Name "Notepad"

# Expected Output:
# NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
# ------    -----      -----     ------      --  -- -----------
#     15     5.23      25.45      0.12   54321   1 Notepad
#
# NOTE: Start-Process parameters:
# -FilePath: Path to executable
# -ArgumentList: Arguments to pass
# -WorkingDirectory: Starting directory
# -PassThru: Return process object
# -Wait: Wait for process to exit
# -NoNewWindow: Run without new window (console apps)

