# Figure 12.15 - Auto-Reply Messages in Mailboxes
# Chapter 12: Microsoft 365 with PowerShell
# PowerShell Advanced Cookbook - BPB Publications
#
# This figure shows screenshots of mailboxes that have received auto-replies.
#
# Auto-replies (Out of Office) can be configured using:
# Set-MailboxAutoReplyConfiguration -Identity <mailbox> `
#     -AutoReplyState Enabled `
#     -InternalMessage "I am currently out of the office." `
#     -ExternalMessage "I am currently out of the office."
#
# To view auto-reply settings:
# Get-MailboxAutoReplyConfiguration -Identity <mailbox>
