# Figure 4.11 - Exploring System.Exception Members
# Chapter 4: Error Handling
# PowerShell Advanced Cookbook - BPB Publications
#
# This demonstrates how to explore the System.Exception base class
# to understand what properties and methods are available for
# custom error handling and exception design.

# ============================================================================
# EXPLORING EXCEPTION MEMBERS
# ============================================================================

# Create a System.Exception object and examine its members
# This is the base class for all .NET exceptions
New-Object System.Exception | Get-Member

# ============================================================================
# SYSTEM.EXCEPTION MEMBER OVERVIEW
# ============================================================================

# PROPERTIES available on all exceptions:
# - Message        : Human-readable error description
# - InnerException : The exception that caused this exception (chaining)
# - StackTrace     : Call stack at point of exception
# - Source         : Name of application/object that caused error
# - HelpLink       : Link to help documentation
# - HResult        : HRESULT error code (COM interop)
# - TargetSite     : Method that threw the exception
# - Data           : Dictionary for additional information

# METHODS available on all exceptions:
# - ToString()          : Full exception information as string
# - GetBaseException()  : Gets root cause in exception chain
# - GetType()           : Returns the exception type
# - GetHashCode()       : Hash code for comparison
# - Equals()            : Equality comparison

# ============================================================================
# WHY EXPLORE EXCEPTION MEMBERS?
# ============================================================================

# Understanding these members helps you:
# 1. Build custom exception classes (inherit and override)
# 2. Extract useful information from caught exceptions
# 3. Create informative error messages
# 4. Implement proper exception chaining
# 5. Add custom properties for specialized error handling

# ============================================================================
# ACCESSING EXCEPTION MEMBERS IN CATCH BLOCKS
# ============================================================================

# In a catch block, access these via $_.Exception:
#
# try {
#     Get-Content "NonExistentFile.txt" -ErrorAction Stop
# }
# catch {
#     # Access exception properties
#     $_.Exception.Message       # Error message
#     $_.Exception.GetType()     # Exception type
#     $_.Exception.StackTrace    # Call stack
#     $_.Exception.InnerException # Underlying cause
# }

# ============================================================================
# COMMON EXCEPTION TYPES IN POWERSHELL
# ============================================================================

# - System.Exception                              : Base class
# - System.Management.Automation.RuntimeException : PowerShell runtime errors
# - System.IO.FileNotFoundException               : File not found
# - System.UnauthorizedAccessException            : Permission denied
# - System.ArgumentException                      : Invalid argument
# - System.InvalidOperationException              : Invalid state for operation
# - System.Net.WebException                       : Network/web errors

# Expected Output:
# (List of TypeName, Name, MemberType, and Definition for System.Exception)
#
# TypeName: System.Exception
#
# Name               MemberType Definition
# ----               ---------- ----------
# Equals             Method     bool Equals(System.Object obj)
# GetBaseException   Method     System.Exception GetBaseException()
# GetHashCode        Method     int GetHashCode()
# GetObjectData      Method     void GetObjectData(...)
# GetType            Method     type GetType()
# ToString           Method     string ToString()
# Data               Property   System.Collections.IDictionary Data {get;}
# HelpLink           Property   string HelpLink {get;set;}
# HResult            Property   int HResult {get;}
# InnerException     Property   System.Exception InnerException {get;}
# Message            Property   string Message {get;}
# Source             Property   string Source {get;set;}
# StackTrace         Property   string StackTrace {get;}
# TargetSite         Property   System.Reflection.MethodBase TargetSite {get;}
