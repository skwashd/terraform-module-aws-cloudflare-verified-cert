variable "aws_tags" {
  description = "A map of tags to add to the AWS resources."
  type        = map(string)
}

variable "cert_cn" {
  description = "The common name for the TLS certificate."
  type        = string
}

variable "cert_sans" {
  description = "A list of subject alternative names for the TLS certificate."
  type        = list(string)
  default     = []
}

variable "cloudflare_tags" {
  description = "A map of tags to add to the Cloudflare resources. Not available for free plan users."
  type        = list(string)
  default     = []
}

variable "zone_name" {
  description = "The name of the Cloudflare zone."
  type        = string
}
