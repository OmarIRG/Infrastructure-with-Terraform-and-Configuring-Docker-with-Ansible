output "private_instance_ips" {
  value = module.ec2.private_instance_ips
}

output "bastion_public_ip" {
  value = module.ec2.bastion_public_ip
}