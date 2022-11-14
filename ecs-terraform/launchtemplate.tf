#------------------------------------------------------------------------------
# AWS EC2 LAUNCH TEMPLATE
#------------------------------------------------------------------------------
resource "aws_iam_instance_profile" "ecsInstanceRole1" {
  name = "ecsInstanceRole1"
  role = aws_iam_role.ecsInstanceRole1.name
}


resource "aws_launch_template" "ecslt" {
  name_prefix   = "ecslt"
  image_id      = "ami-0fe77b349d804e9e6"   #ecs optimized image from aws
  instance_type = "t2.medium"                # instance type have to choose on the basis how much cpu and memory is required by your tasks to run
  key_name      = "test1"                   #key pair
  user_data     = "#!/bin/bash\necho ECS_CLUSTER=test >> /etc/ecs/ecs.config" # userdata to register the instance with the cluster

  iam_instance_profile {
    name = aws_iam_instance_profile.ecsInstanceRole1.name  #ecsInstancerole to be attached with the lauched instance to run the ecs TD
  }

}
