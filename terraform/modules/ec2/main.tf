resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key"
  public_key = file("/home/omar/.ssh/bastion.pub")
}

resource "aws_security_group" "bastion_sg" {
  name        = "bastion-sg"
  description = "Security group for Bastion host"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["41.234.175.200/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id
  key_name      = aws_key_pair.bastion_key.key_name
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_security_group" "private_sg" {
  name        = "private-sg"
  description = "Security group for private instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # Allow HTTP (port 80) traffic from the load balancer or from within the VPC
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # Adjust this to your VPC CIDR block
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "private" {
  count         = length(var.private_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.private_subnet_ids, count.index)
  key_name      = aws_key_pair.bastion_key.key_name
  vpc_security_group_ids = [aws_security_group.private_sg.id]

  tags = {
    Name = "Private Instance ${count.index}"
  }
}
