output security_group_rds_id {
  value = aws_security_group.rds.id
}

output security_group_ecs_id {
  value = aws_security_group.ecs.id
}

output security_group_ecs_lb_id {
  value = aws_security_group.ecs_lb.id
}

output vpc_id {
  value = aws_vpc.this.id
}

output public_subnet_ids {
  value = aws_subnet.public.*.id
}