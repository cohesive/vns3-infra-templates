# Launch VNS3 in an existing VPC

This is a very simple Cloudformation format to get started launching VNS3 in an existing VPC. It will create the following:

1. An Elastic IP address
2. A VNS3 instance from the AWS marketplace

It will return the following outputs:

1. Public IP address of VNS3
2. The instance ID of VNS3

You can then login to VNS3 via the VNS3 Console at https://VNS3PublicIp:8000/ with default login credentials:

username: vnscubed
password: VNS3InstanceId
