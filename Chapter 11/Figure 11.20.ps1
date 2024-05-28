# Counting (Listing) AMIs using a filter
$Filter = @{
    Name = "architecture"; Values = "x86_64"
}, @{
    Name = "description"; Values = "Amazon Linux 2 AMI*"
}, @{
    Name = "is-public"; Values = "true"
}, @{
    Name = "state"; Values = "available"
}

(Get-EC2Image -Region eu-north-1 -Filter $Filter).count
