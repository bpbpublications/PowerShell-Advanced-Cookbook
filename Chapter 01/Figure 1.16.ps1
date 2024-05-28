# Create a new TestKey under HKCU:\Software
New-Item -Path "HKCU:\Software\TestKey"
# Create a new SubTestKey under HKCU:\Software\TestKey
New-Item -Path "HKCU:\Software\TestKey\SubTestKey"
# Set test properties for TestKey
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value1" -Value "TestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value2" -Value "TestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey" -Name "Value3" -Value "TestValue3"
# Set test properties for SubTestKey
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue1" -Value "SubTestValue1"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue2" -Value "SubTestValue2"
Set-ItemProperty -Path "HKCU:\Software\TestKey\SubTestKey" -Name "SubValue3" -Value "SubTestValue3"

Get-ItemProperty HKCU:\SOFTWARE\TestKey -Name Value1

$Value1 = Get-ItemProperty HKCU:\SOFTWARE\TestKey -Name Value1
$Value1.Value1