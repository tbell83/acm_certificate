variable "mod_count" {
  default = 1
}

variable "tags" {
  type = map(string)

  default = {
    Managed = "acm_certificate_module"
  }
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
}

variable "domain_root" {
  description = "The root domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  type        = list
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "cross_account" {
  default = false
  type    = bool
}

variable "certificate_transparency_logging_preference" {
  default     = "ENABLED"
  description = "Specifies whether certificate details should be added to a certificate transparency log. Valid values are ENABLED or DISABLED. See https://docs.aws.amazon.com/acm/latest/userguide/acm-concepts.html#concept-transparency for more details."
}
