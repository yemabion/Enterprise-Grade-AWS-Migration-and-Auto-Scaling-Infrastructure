resource "aws_cloudwatch_log_group" "wordpress" {
  name              = "/enterprise/wordpress-migration"
  retention_in_days = 30

  tags = {
    Name = "${var.project_name}-logs"
  }
}

resource "aws_cloudwatch_metric_alarm" "wordpress_cpu" {
  alarm_name          = "${var.project_name}-high-cpu"
  alarm_description   = "Monitors CPU utilization on the WordPress EC2 instance"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 80

  dimensions = {
    InstanceId = aws_instance.wordpress.id
  }

  treat_missing_data = "notBreaching"

  tags = {
    Name = "${var.project_name}-cpu-alarm"
  }
}