resource "aws_ecr_repository" "ecr" {
  name = "${var.service_name}-${var.env}-${var.role}"
  tags = merge(
    var.ecr_additional_tags,
    {
      ServiceName = var.service_name
      Env = var.env
    }
  )
  image_tag_mutability = var.image_tag_mutability
}

resource "aws_ecr_repository_policy" "policy" {
    repository = aws_ecr_repository.repository.name
    policy = var.repository_lifecycle_policy == "" ? file("${path.module}/lifecycle_policy/default_policy.json") : var.repository_lifecycle_policy
}