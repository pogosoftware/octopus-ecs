output ecs_cluster_octopus_id {
  value = aws_ecs_cluster.octopus.id
}

output ecs_octopus_server_target_group_arn {
  value = aws_lb_target_group.ecs_octopus_server.arn
}

output lb_dns_name {
  value = aws_lb.ecs.dns_name
}