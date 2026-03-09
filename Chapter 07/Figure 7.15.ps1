# Figure 7.15 - Infrastructure Testing with Pester
# Chapter 7: Testing with Pester
# PowerShell Advanced Cookbook - BPB Publications
#
# Platform: Windows (uses Test-NetConnection, Azure CLI)
# Demonstrates using Pester for infrastructure validation testing.

# ============================================================================
# NETWORK CONNECTIVITY TESTS
# ============================================================================

Describe -Tag "Network" "Website connections" {
    Context "Google site Tests" {
        It "Test Google network connectivity" {
            $Result = Test-NetConnection "www.google.com"
            $Result.PingSucceeded | Should -Be $true
        }
        It "Test google port 443 availability" {
            $Result = Test-NetConnection "www.google.dk" -Port 443
            $Result.TcpTestSucceeded | Should -Not -Be $false
        }
    }
    Context "Bio-Rent site Tests" {
        It "Test Bio-Rent network connectivity" {
            $Result = Test-NetConnection "Bio-Rent.dk"
            $Result.PingSucceeded | Should -Be $true
        }
        It "Test Bio-Rent port 443 availability" {
            $Result = Test-NetConnection "Bio-Rent.dk" -Port 443
            $Result.TcpTestSucceeded | Should -Not -Be $false
        }
    }
}

# ============================================================================
# SERVER CONNECTIVITY TESTS
# ============================================================================

# Note: These servers must exist in your environment
Describe -Tag "Network" "Server connections" {
    Context "Webservers" {
        It "Should be able to ping PS-HOST01" {
            $Result = Test-Connection -ComputerName "PS-HOST01" -Count 1
            $Result.Status | Should -Be "Success"
        }
        It "Should be able to ping PS-CLIENT01" {
            $Result = Test-Connection -ComputerName "PS-CLIENT01" -Count 1
            $Result.Status | Should -Be "Success"
        }
    }
    Context "Domain Controllers" {
        It "Should be able to ping DC01.Moppleit.dk" {
            $Result = Test-Connection -ComputerName "DC01" -Count 1
            $Result.Status | Should -Be "Success"
        }
    }
}

# ============================================================================
# DATABASE CONNECTIVITY TESTS
# ============================================================================

# Requires: Install-Module SqlServer
Describe -Tag "Database" "Database tests" {
    Context "Database tests: MyDatabase" {
        It "Should connect to the database and retreive data" {
            $databaseServer = "DBServer"
            $databaseName = "MyDatabase"
            $query = "SELECT COUNT(*) FROM MyTable"

            $result = Invoke-Sqlcmd -ServerInstance $databaseServer -Database $databaseName -Query $query
            $result[0].Column1 | Should -BeGreaterThan 0
        }
    }
}

# ============================================================================
# AZURE CLOUD INFRASTRUCTURE TESTS
# ============================================================================

# Requires: Azure CLI installed and configured
Describe -Tag "Azure" "Cloud Tests" {
    BeforeAll {
        # Login to Azure if not already authenticated
        if (-not ((az account list --query "[].id" --output tsv) -contains "<AZURE SUBSCRIPTION ID>") ) {
            az login
        }
    }
    Context "Test Resource Groups" {
        It "Resource group: RG-Test should exist" {
            $Result = az group exists --name "RG-Test"
            $Result | Should -Match true
        }
    Context "Other Azure tests" {
        It "App Registration should exist" {
            $Result = az ad app list --display-name "TestApp" --query "[0].appId" --output tsv
            $Result | Should -Not -BeNullOrEmpty
        }
    }
    }
    AfterAll {
        az logout
    }
}

# ============================================================================
# RUN INFRASTRUCTURE TESTS
# ============================================================================

$PesterConfig = New-PesterConfiguration
$PesterConfig.Output.Verbosity = "Detailed"

# Run only network tests:
# $PesterConfig.Filter.Tag = "Network"

Invoke-Pester -Configuration $PesterConfig
