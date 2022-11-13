#------------------------------------------------------------------------------
# AWS ECS Service
#------------------------------------------------------------------------------

resource "aws_ecr_repository" "testrepo" {
  name                 = "testrepo"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
