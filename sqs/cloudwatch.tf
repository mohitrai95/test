#------------------------------------------------------------------------------
# AWS Autoscaling policy
#------------------------------------------------------------------------------

resource "aws_autoscaling_policy" "sqs" {
  name                   = "sqs-terraform-test"
  scaling_adjustment     = 2
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.sqs-asg.name
}

#------------------------------------------------------------------------------
# AWS Cloudwatch Alarm
#------------------------------------------------------------------------------

resource "aws_cloudwatch_metric_alarm" "sqs" {
 alarm_name          = "sqs-alarm"
 comparison_operator = "GreaterThanOrEqualToThreshold"
 evaluation_periods  = "1"
 metric_name         = "ApproximateNumberOfMessagesVisible"
 namespace           = "AWS/SQS"
 period              = "60"
 statistic           = "Average"
 threshold           = "1"
 treat_missing_data = "notBreaching"

  dimensions = {
    QueueName            = "${aws_sqs_queue.sqs1.name}"
    AutoScalingGroupName = aws_autoscaling_group.sqs-asg.name
  }

  alarm_description = "This metric monitors ec2 cpu utilization"
  alarm_actions     = [aws_autoscaling_policy.sqs.arn]
}
