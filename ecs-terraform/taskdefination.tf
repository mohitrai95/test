#------------------------------------------------------------------------------
# AWS ECS Task Defination
#------------------------------------------------------------------------------

resource "aws_ecs_task_definition" "my_first_task" {
  family                   = "my-first-task" # Naming our first task
  container_definitions    = <<DEFINITION
  [
    {
      "name": "my-first-task",
      "image": "092343539091.dkr.ecr.us-east-1.amazonaws.com/nginx:latest",
      "essential": true,
      "portMappings": [
        {
          "containerPort": 80,
          "hostPort": 80
        }
      ],
      "memory": 512,
      "cpu": 256
    }
  ]
  DEFINITION
  requires_compatibilities = ["EC2"]  # Stating that we are using ECS Fargate
  network_mode             = "bridge" # Using awsvpc as our network mode as this is required for Fargate
  memory                   = 512      # Specifying the memory our container requires
  cpu                      = 256      # Specifying the CPU our container requires
  execution_role_arn       = "arn:aws:iam::092343539091:role/ecsTaskExecutionRole"
}
