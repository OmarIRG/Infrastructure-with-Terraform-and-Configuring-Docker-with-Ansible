

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.alb.dns_name  # Make sure 'alb' matches your resource name in the module
}
