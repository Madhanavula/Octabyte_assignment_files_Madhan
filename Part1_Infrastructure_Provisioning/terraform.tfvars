aws_region   = "ap-south-1"
project_name = "octabyte-devops-assignment"

key_name = "devops-assignment-key"

vpc_cidr = "10.0.0.0/16"

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.3.0/24",
  "10.0.4.0/24"
]

availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]

instance_type = "t3.micro"

# Verify this AMI ID for ap-south-1 before deployment
ami_id = "ami-0f918f7e67a3323f0"

db_name     = "appdb"
db_username = "dbadmin"
db_password = "Admin123!"

db_instance_class = "db.t3.micro"