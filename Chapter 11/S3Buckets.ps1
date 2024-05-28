$Region = eu-north-1

# List all S3 Bucket cmdlets
Get-Command | Where-Object {$_.Name -match "S3"}

# Create a new S3 Bucket. Name must be unique accross AWS
New-S3Bucket `
-BucketName "moppleit-test-bucket" `
-Region $Region

# List all S3 Bucktes in an account accross regions
Get-S3Bucket

# Get different information and properties of a specific bucket

# Get bucket Access Controll List (ACL)
Get-S3ACL -BucketName moppleit-test-bucket

# Get bucket encryption scheme
Get-S3BucketEncryption moppleit-test-bucket

# Get bucket location (Region)
Get-S3BucketLocation moppleit-test-bucket

# Get bucket attached policies
Get-S3BucketPolicy moppleit-test-bucket

# Get bucket tags
Get-S3BucketTagging moppleit-test-bucket

# upload file to bucket
Write-S3Object -BucketName moppleit-test-bucket `
-File "C:\Temp\Data.zip"

# upload file to bucket in specific key (path)
Write-S3Object -BucketName moppleit-test-bucket `
-File "C:\Temp\MoreData.zip" `
-Key "ZipFiles/MoreData/MoreData.zip"

# upload file to bucket in specific key (path)
Write-S3Object -BucketName moppleit-test-bucket `
-File "C:\Temp\MostData.zip" `
-Key "ZipFiles/MoreData/MostData.zip"

# Upload a folder to a bucket
Write-S3Object -BucketName moppleit-test-bucket `
-Folder "C:\Temp\Files" `
-KeyPrefix "Temp/Files" `
-Recurse

# list all objects in an S3 bucket
Get-S3Object -BucketName moppleit-test-bucket

# list a specific object in an S3 bucket
Get-S3Object -BucketName moppleit-test-bucket `
-Key "Temp/Files/Books.xml"

# List all objects in a specific key (path)
Get-S3Object -BucketName moppleit-test-bucket `
-KeyPrefix "Temp/Files"

# Read (download) a specific file from a bucket
Read-S3Object -BucketName moppleit-test-bucket `
-Key "Temp/Files/Books.xml" `
-File "C:\Temp\Books.xml"

# Read (download) all content from a keyprefix (folder) in a bucket
Read-S3Object -BucketName moppleit-test-bucket `
-KeyPrefix "Temp/Files" `
-Folder "C:\Temp\NewTemp"

# Delete a specific file in a bucket
Remove-S3Object -BucketName moppleit-test-bucket `
-Key "Temp/Files/Books.xml" `
-Confirm:$false

# Delete a folder in a bucket
Get-S3Object -BucketName moppleit-test-bucket `
-KeyPrefix "Temp/Files" | `
Remove-S3Object `
-Force

# Delete an S3 bucket
Remove-S3Bucket -BucketName moppleit-test-bucket `
-DeleteBucketContent `
-Force

# Create a new bucket
$BucketName = "moppleit-s3"
New-S3Bucket -BucketName $BucketName -Region $Region

# Upload file to bucket
Write-S3Object -BucketName $BucketName `
-File "C:\Temp\Data.zip"

# Download file from bucket (Save with a new name)
Read-S3Object -BucketName $BucketName `
-Key "Data.zip" `
-File "C:\Temp\NewData.zip"

# Delete bucket
Remove-S3Bucket -BucketName $BucketName `
-DeleteBucketContent `
-Force

# Limit access to bucket for a specific IAM group, using policies
# Create a new IAM Group
New-IAMGroup -GroupName BucketAccess

# Create a new S3 bucket
New-S3Bucket -BucketName moppleit-access-limit `
-Region eu-north-1

# Policy for Get and Put objects in the bucket
$AccessPolicy = @"
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:GetObject",
                "s3:PutObject"
            ],
            "Resource": "arn:aws:s3:::moppleit-access-limit/*"
        }
    ]
}
"@

# Create the new policy
$GroupPolicy = New-IAMPolicy -PolicyName "AccessS3-moppleit-access-limit" `
-PolicyDocument $AccessPolicy `
-Description "This grants Get/Put on S3 moppleit-access-limit"

# Attach the policy to the IAM group
Register-IAMGroupPolicy -GroupName "BucketAccess" `
-PolicyArn $GroupPolicy.Arn
