provider "aws" {
  region = "eu-west-1"  # Use the correct EU region code
}

module "vpc" {
  source    = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc"
}