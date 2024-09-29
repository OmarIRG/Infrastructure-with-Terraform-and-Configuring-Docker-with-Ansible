output "bastion_public_ip" {
  value = aws_instance.bastion.public_ip
}

output "private_instance_ips" {
  value = aws_instance.private[*].private_ip
}

output "private_instance_ids" {
  description = "The IDs of the private EC2 instances"
  value       = aws_instance.private.*.id  # Correct resource reference
}
