
module "vpc" {
  source    = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc"
  public_subnet_ids = module.subnets.public_subnet_ids
}

module "subnets" {
  source              = "./modules/subnets"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.3.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24", "10.0.4.0/24"]
  availability_zones  = ["eu-west-1a", "eu-west-1b"]
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  public_subnet_id   = module.subnets.public_subnet_ids[0]  # Select the first public subnet for EC2
  private_subnet_ids = module.subnets.private_subnet_ids

  # Required variables for the EC2 module
  ami               = var.ami               # Add the AMI you want to use for EC2 instances
  instance_type     = var.instance_type     # Define the EC2 instance type (e.g., t2.micro)
}

module "alb" {
  source = "./modules/alb"  # Correct path to the ALB module inside the 'modules' directory
  vpc_id = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  private_instance_ids = module.ec2.private_instance_ids
  private_instance_ips = module.ec2.private_instance_ips
  web_server_port = var.web_server_port
}
