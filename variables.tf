variable "mod_count" {
  default = 1
}

variable "tags" {
  type = "map"

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
  type        = "list"
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "cross_account" {
  default = "false"
}
