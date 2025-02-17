
output "acm_certificate_arn" {
  description = "The ARN of the ACM certificate"
  value       = aws_acm_certificate.this.arn
}

output "cloudflare_zone_id" {
  description = "The ID of the Cloudflare zone"
  value       = data.cloudflare_zone.this.zone_id
}

output "dns_record" {
  description = "The names of the Cloudflare DNS records"
  value = {
    for record in cloudflare_dns_record.verify : record.name => {
      target = record.content
      type   = record.type
    }
  }
}
