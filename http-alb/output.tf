output "alb-dns-name" {
	value = aws_lb.application-lb.dns_name
}

output "instance_id1" {
	value = aws_instance.web-server[0].id
}

output "instance_id2" {
	value = aws_instance.web-server[1].id
}