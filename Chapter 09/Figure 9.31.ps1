# Figure 9.31 - CSV File Format for Bulk User Creation
# Chapter 9: Active Directory Management
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows only (requires AD DS or RSAT)
# Shows the CSV file format used by CreateBulkADUsers.ps1.

# ============================================================================
# CSV FILE FORMAT
# ============================================================================

# Content of BulkUsers.csv file
# Note: Uses semicolon (;) as delimiter

# GivenName;SurName;JobTitle;Department;Country;MobilPhone
# Olivia;Smith;Employee;HR;GB;+4477665544
# William;Brown;Manager;Finance;DK;+4588991100
# James;Wilson;Developer;Development;DK;+4599118877
# Benjamin;Harris;Manager;Finance;GB;+4477663344
# Lucas;Johnson;Developer;Development;GB;+4489887766
# Emma;Lee;Helpdesk;IT;GB;+4477112233
# Sophia;Anderson;Helpdesk;IT;DK;+4555447799
# Liam;Clark;Employee;HR;DK;+4533221100
# Mia;Davis;Manager;Finance;DK;+4577889900
# Ava;Williams;Employee;HR;GB;+4433554477

# ============================================================================
# CSV REQUIREMENTS
# ============================================================================

# - Header row must match expected column names exactly
# - Delimiter must match Import-Csv -Delimiter parameter
# - Country must be valid (DK or GB in this example)
# - All required fields must be populated
# - No empty rows or trailing delimiters
