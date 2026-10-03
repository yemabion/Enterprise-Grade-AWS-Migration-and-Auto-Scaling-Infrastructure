resource "aws_iam_role" "wordpress_ec2" {
  name = "${var.project_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.project_name}-ec2-role"
  }
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.wordpress_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch_agent" {
  role       = aws_iam_role.wordpress_ec2.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_role_policy" "migration_s3" {
  name = "${var.project_name}-s3-migration-policy"
  role = aws_iam_role.wordpress_ec2.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "ListMigrationBucket"
        Effect = "Allow"

        Action = [
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.migration.arn
      },
      {
        Sid    = "ReadMigrationObjects"
        Effect = "Allow"

        Action = [
          "s3:GetObject"
        ]

        Resource = "${aws_s3_bucket.migration.arn}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "wordpress_ec2" {
  name = "${var.project_name}-ec2-profile"
  role = aws_iam_role.wordpress_ec2.name

  tags = {
    Name = "${var.project_name}-ec2-profile"
  }
}