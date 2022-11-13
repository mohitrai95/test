#------------------------------------------------------------------------------
# AWS Launch Template
#------------------------------------------------------------------------------
resource "aws_launch_template" "lt2" {
  name_prefix   = "lt2"
  image_id      = "ami-0fe77b349d804e9e6"
  instance_type = "t2.micro"
  user_data = base64encode("echo ECS_CLUSTER= example >> /etc/ecs/ecs.config")

}
#------------------------------------------------------------------------------
# AWS Autoscaling Group
#------------------------------------------------------------------------------

resource "aws_autoscaling_group" "sqs-asg" {
  name               = "sqs-asg"
  availability_zones = ["us-east-1a"]
  desired_capacity   = 1
  max_size           = 1
  min_size           = 1

  launch_template {
    id      = aws_launch_template.lt2.id
    version = "$Latest"
  }
}
