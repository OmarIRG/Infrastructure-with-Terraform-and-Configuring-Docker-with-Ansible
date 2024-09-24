resource "aws_lb" "main" {
  name               = "main-alb"
  load_balancer_type = "application"
  subnets            = var.public_subnet_ids

  tags = {
    Name = "Main Application Load Balancer"
  }
}
