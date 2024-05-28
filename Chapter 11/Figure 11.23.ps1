# It is easy to create and manage buckets

$Region = eu-north-1
$BucketName = "moppleit-s3"
New-S3Bucket -BucketName $BucketName -Region $Region

Write-S3Object -BucketName $BucketName `
-File "C:\Temp\Data.zip"

Read-S3Object -BucketName $BucketName `
-Key "Data.zip" `
-File "C:\Temp\NewData.zip"

Remove-S3Bucket -BucketName $BucketName `
-DeleteBucketContent `
-Force

Get-S3Bucket moppleit-s3