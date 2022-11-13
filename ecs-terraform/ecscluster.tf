#------------------------------------------------------------------------------
# AWS ECS CLUSTER & CAPACITY PROVIDER with attached ASG
#------------------------------------------------------------------------------
resource "aws_ecs_cluster" "test" {
  name = "test"
}

resource "aws_ecs_cluster_capacity_providers" "example" {
  cluster_name = aws_ecs_cluster.test.name

  capacity_providers = [aws_ecs_capacity_provider.test.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.test.name
  }
}

resource "aws_ecs_capacity_provider" "test" {
  name = "test"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.asg.arn
  }
}
