configuration ConfigDSCHOST01 {
    Node "DSCHOST01" {
        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 15
            RebootNodeIfNeeded = $true
        }
    }
}

configuration ConfigDSCHOST02 {
    Node "DSCHOST02" {
        LocalConfigurationManager {
            ConfigurationMode = "ApplyAndAutoCorrect"
            ConfigurationModeFrequencyMins = 20
            RebootNodeIfNeeded = $true
        }
    }
}

#ConfigDSCHOST01
#ConfigDSCHOST02