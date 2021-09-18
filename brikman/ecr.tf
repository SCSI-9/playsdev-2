resource "aws_ecr_repository" "playsdev-ecr" {
  name                 = "playsdev-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
