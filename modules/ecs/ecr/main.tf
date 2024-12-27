resource "aws_ecr_repository" "main" {
  name                 = "${var.name_prefix}-${var.env}-${var.repository_type}-repo"
  image_tag_mutability = "MUTABLE"

  tags = merge(
    {
      Name = "${var.name_prefix}-${var.env}-${var.repository_type}-repo"
    },
    var.tags
  )
}