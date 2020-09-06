resource "aws_key_pair" "this" {
  key_name   = "octopus"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_iam_role" "container_instance_ec2" {
  name               = "container_instance_ec2"
  assume_role_policy = data.aws_iam_policy_document.container_instance_ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "ec2_service_role" {
  role       = aws_iam_role.container_instance_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_instance_profile" "container_instance" {
  name = aws_iam_role.container_instance_ec2.name
  role = aws_iam_role.container_instance_ec2.name
}

resource "aws_launch_configuration" "this" {
  name_prefix                 = var.lc_name_prefix
  image_id                    = data.aws_ami.ecs.id
  instance_type               = var.lc_instance_type
  iam_instance_profile        = aws_iam_instance_profile.container_instance.name
  key_name                    = aws_key_pair.this.key_name
  associate_public_ip_address = var.lc_associate_public_ip_address
  enable_monitoring           = var.lc_enable_monitoring
  security_groups             = var.lc_security_groups

  user_data = templatefile("${path.module}/templates/container-instance.tmpl", {
    ecs_cluster_name = var.ecs_cluster_name
  })

  root_block_device {
    volume_type = "gp2"
    volume_size = 30
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name                 = var.asg_name
  launch_configuration = aws_launch_configuration.this.name

  max_size         = var.asg_max_size
  min_size         = var.asg_min_size
  desired_capacity = var.asg_desired_capacity

  vpc_zone_identifier = var.vpc_subnet_ids

  lifecycle {
    ignore_changes = [load_balancers, target_group_arns]
  }
}
