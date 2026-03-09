# Figure 13.6 - Compiled MOF Configuration File
# Chapter 13: Desired State Configuration (DSC)
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (PowerShell 5.1 with DSC)
# Prerequisites: PSDesiredStateConfiguration module

# ============================================================================
# MOF FILE STRUCTURE
# ============================================================================

# This figure shows the structure of a compiled DSC configuration file (.mof)
# MOF = Managed Object Format, a standard format for describing system objects
#
# When you compile a DSC configuration, PowerShell generates a .mof file
# for each target node specified in the configuration.
#
# Example compiled MOF structure (DSCConfigs/DSCHOST01.mof):
# ┌─────────────────────────────────────────────────────────────────────┐
# │ /*                                                                   │
# │ @TargetNode='DSCHOST01'                                             │
# │ @GeneratedBy=Administrator                                          │
# │ @GenerationDate=01/01/2024 10:00:00                                 │
# │ @GenerationHost=DSCSERVER                                           │
# │ */                                                                   │
# │                                                                      │
# │ instance of MSFT_EnvironmentResource as $MSFT_EnvironmentResource1  │
# │ {                                                                    │
# │   ResourceID = "[Environment]CreateEnvironmentVariable";            │
# │   Ensure = "Present";                                               │
# │   Name = "DSCNODE";                                                 │
# │   Value = "DSCHOST01";                                              │
# │   Path = True;                                                      │
# │   ModuleName = "PSDesiredStateConfiguration";                       │
# │   ModuleVersion = "1.0";                                            │
# │   ConfigurationName = "SimpleDsc";                                  │
# │ };                                                                   │
# └─────────────────────────────────────────────────────────────────────┘
#
# MOF files are stored in:
# - Regular configs: .\<ConfigurationName>\<NodeName>.mof
# - Meta configs: .\<ConfigurationName>\<NodeName>.meta.mof
#
# See the DSCConfigs directory for example compiled MOF files

