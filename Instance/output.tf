output "Ip-instancia" {
  value = aws_instance.cframirez-platzi-instance.*.public_ip
}