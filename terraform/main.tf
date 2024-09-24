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
  source             = "./modules/ec2"          # Amazon Linux 2 AMI ID for eu-west-1 (Free Tier eligible)
  ami                = "ami-0c3a915e3f3aa0e0d"  # ami-00399ec92321828f5
  instance_type      = "t2.micro"
  public_subnet_id   = element(module.subnets.public_subnet_ids, 0)
  private_subnet_ids = module.subnets.private_subnet_ids
  vpc_id             = var.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  public_subnet_ids = module.subnets.public_subnet_ids
}
