resource "aws_instance" "bastion" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.public_subnet_id

  tags = {
    Name = "Bastion Host"
  }
}

resource "aws_instance" "private" {
  count         = length(var.private_subnet_ids)
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = element(var.private_subnet_ids, count.index)

  tags = {
    Name = "Private Instance ${count.index}"
  }
}
