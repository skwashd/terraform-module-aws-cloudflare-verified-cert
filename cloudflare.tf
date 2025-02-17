data "cloudflare_zone" "this" {
  filter = {
    name = var.zone_name
  }
}

resource "cloudflare_dns_record" "verify" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  zone_id = data.cloudflare_zone.this.zone_id
  comment = "Verify ${aws_acm_certificate.this.arn}"

  name    = each.value.name
  content = each.value.record
  type    = each.value.type

  proxied = false
  ttl     = 3600

  tags = var.cloudflare_tags
}
