output "ec2_instance_one_public_ip" {
  value       = aws_instance.web1.public_ip
  description = "The public ip of the EC2 instance one we created"
}

output "ec2_instance_one_instance_id" {
  value       = aws_instance.web1.id
  description = "The instance id of the EC2 instance one we created"
}