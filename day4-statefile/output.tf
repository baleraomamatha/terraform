output "public" {
    value = aws_instance.developer.public_ip
  sensitive = true
}
output "private" {
    value = aws_instance.developer.private_ip
  
}