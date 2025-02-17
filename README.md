# Terraform Module to Create ACM Certs & Verify them with Cloudflare

This module create AWS ACM TLS certificates, then verifies them by adding records to Cloudflare.

This module requires both the AWS and Cloudflare providers to be properly configured. It assumes all records are in the same zone.

We recommend setting the Cloudflare credentials via the `CLOUDFLARE_API_TOKEN` environment variable. This token must have write access on the DNS records for your zone. For more information on configuring the Cloudflare provider, refer to the [documentation](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs).

## Example

A common use case for this module is managing the certificates for a load balancer. Below is an (incomplete) example of how to do that.

```hcl2
module "certs" {
  source = "..."

  zone_name = "example.com"

  cert_cn = "example.com"
  cert_sans = [
    "api.example.com",
    "www.example.com",
  ]

  aws_tags = var.tags
}

resource "aws_alb" "web" {
  name               = "web"
  load_balancer_type = "application"

  # ...

  tags = var.tags
}

resource "aws_alb_listener" "web_https" {
  load_balancer_arn = aws_alb.web.arn
  port              = 443
  protocol          = "HTTPS"

  certificate_arn = aws_acm_certificate.api.arn

  # ...

  tags = var.tags
}
```

## Generated Documentation

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.10.0, < 2.0.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0.0, < 6.0.0 |
| <a name="requirement_cloudflare"></a> [cloudflare](#requirement\_cloudflare) | >= 5.0.0, < 6.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.87.0 |
| <a name="provider_cloudflare"></a> [cloudflare](#provider\_cloudflare) | 5.1.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [cloudflare_dns_record.verify](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/dns_record) | resource |
| [cloudflare_zone.this](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/data-sources/zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_tags"></a> [aws\_tags](#input\_aws\_tags) | A map of tags to add to the AWS resources. | `map(string)` | n/a | yes |
| <a name="input_cert_cn"></a> [cert\_cn](#input\_cert\_cn) | The common name for the TLS certificate. | `string` | n/a | yes |
| <a name="input_cert_sans"></a> [cert\_sans](#input\_cert\_sans) | A list of subject alternative names for the TLS certificate. | `list(string)` | `[]` | no |
| <a name="input_cloudflare_tags"></a> [cloudflare\_tags](#input\_cloudflare\_tags) | A map of tags to add to the Cloudflare resources. Not available for free plan users. | `list(string)` | `[]` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | The name of the Cloudflare zone. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acm_certificate_arn"></a> [acm\_certificate\_arn](#output\_acm\_certificate\_arn) | The ARN of the ACM certificate |
| <a name="output_cloudflare_zone_id"></a> [cloudflare\_zone\_id](#output\_cloudflare\_zone\_id) | The ID of the Cloudflare zone |
| <a name="output_dns_record"></a> [dns\_record](#output\_dns\_record) | The names of the Cloudflare DNS records |
<!-- END_TF_DOCS -->