#------------------------------------------------------------------------------
# AWS ECS Service
#------------------------------------------------------------------------------

resource "aws_ecs_service" "test1" {
  name            = "test1"
  cluster         = aws_ecs_cluster.test.id
  task_definition = aws_ecs_task_definition.my_first_task.arn
  desired_count   = 1
  launch_type     = "EC2"

}
