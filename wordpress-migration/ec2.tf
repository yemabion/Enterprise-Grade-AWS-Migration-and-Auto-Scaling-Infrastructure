data "aws_ssm_parameter" "ubuntu_2204_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "wordpress" {
  ami           = data.aws_ssm_parameter.ubuntu_2204_ami.value
  instance_type = var.instance_type

  subnet_id = aws_subnet.public[0].id

  vpc_security_group_ids = [
    aws_security_group.wordpress.id
  ]

  iam_instance_profile = aws_iam_instance_profile.wordpress_ec2.name

  associate_public_ip_address = true

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    encrypted             = true
    delete_on_termination = true
  }

  user_data = <<-EOF
              #!/bin/bash
              set -eux

              apt-get update
              apt-get upgrade -y

              apt-get install -y \
                apache2 \
                php \
                php-mysql \
                php-curl \
                php-gd \
                php-mbstring \
                php-xml \
                php-xmlrpc \
                php-soap \
                php-intl \
                php-zip \
                unzip \
                wget \
                curl \
                mysql-client

              systemctl enable apache2
              systemctl start apache2

              echo "WordPress Migration Server" > /var/www/html/index.html
              EOF

  tags = {
    Name = "${var.project_name}-wordpress"
  }
}

output "wordpress_instance_id" {
  value = aws_instance.wordpress.id
}

output "wordpress_public_ip" {
  value = aws_instance.wordpress.public_ip
}

output "wordpress_public_dns" {
  value = aws_instance.wordpress.public_dns
}

output "rds_endpoint" {
  value = aws_db_instance.wordpress.address
}