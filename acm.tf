resource "aws_acm_certificate" "this" {
  domain_name = var.cert_cn

  subject_alternative_names = var.cert_sans

  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }

  tags = var.aws_tags
}
