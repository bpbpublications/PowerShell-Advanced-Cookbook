# Figure 15.5 - Form Control Events and Functions
# Chapter 15: PowerShell Studio and Windows Services
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell Studio - SAPIEN Technologies)
# Prerequisites: PowerShell Studio installed
#
# This demonstrates event handlers and functions in PowerShell Studio forms.

# ============================================================================
# FORM LOAD EVENT
# ============================================================================

# The Load event fires when the form is first displayed
# Use this to initialize form controls and set default values
$formTestApplication_Load = {
    # TODO: Initialize Form Controls here
    # Example: $textbox1.Text = "Default value"
    # Example: $combobox1.Items.AddRange(@("Option1", "Option2", "Option3"))
}

# ============================================================================
# BUTTON CLICK EVENT
# ============================================================================

# The Click event fires when the user clicks the button
# This is where you place the action code for the button
$buttonClick_Click = {
    # TODO: Place custom script here
    # Update the label with formatted output from Add-Date function
    $label1.Text = Add-Date
}

# ============================================================================
# HELPER FUNCTION
# ============================================================================

# Custom function to format text with timestamp
# Functions defined in the script can be called from any event handler
function Add-Date {
    # Get current date/time in specific format
    $Date = Get-Date -Format "dd-MM-yyyy HH:mm"

    # Return formatted string with timestamp and textbox content
    # $textbox1 is a form control accessible in this scope
    return "[$($Date)]: $($textbox1.Text)"
}

# Expected Output (when button is clicked with "Hello World" in textbox):
# [12-01-2024 14:30]: Hello World

