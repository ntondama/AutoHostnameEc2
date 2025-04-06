output "instance_public_ip" {
  value = aws_instance.auto_hostname.public_ip
}

output "instance_hostname" {
  value = var.server_name
}
