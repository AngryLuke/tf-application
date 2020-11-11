output "launch_configuration" {
  value = aws_launch_configuration.web-lc.id
}

output "asg_name" {
  value = aws_autoscaling_group.web-asg.id
}

output "elb_name" {
  value = aws_elb.web-elb.dns_name
}

output "key_name" {
  value = aws_key_pair.generated_key.key_name
}

output "public_key" {
  value = tls_private_key.example.public_key_pem
}
