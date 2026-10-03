resource "aws_launch_template" "wordpress" {
  name_prefix   = "${var.project_name}-wordpress-"
  image_id      = var.ami_id
  instance_type = var.instance_type

  iam_instance_profile {
    name = "enterprise-wordpress-migration-ec2-profile"
  }

  vpc_security_group_ids = [
    aws_security_group.wordpress.id
  ]

  monitoring {
    enabled = true
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  block_device_mappings {
    device_name = "/dev/sda1"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "${var.project_name}-wordpress-asg"
    }
  }

  tag_specifications {
    resource_type = "volume"

    tags = {
      Name = "${var.project_name}-wordpress-volume"
    }
  }
}