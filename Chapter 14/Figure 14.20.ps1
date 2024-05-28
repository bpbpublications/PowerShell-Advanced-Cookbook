# Create a new partition
New-Partition -DiskNumber 1 -UseMaximumSize -AssignDriveLetter

# Listing all disks partitions
Get-Partition