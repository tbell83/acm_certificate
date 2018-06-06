variable "count" {
  default = 1
}

variable "tags" {
  type = "map"

  default = {
    Managed = "acm_certificate_module"
  }
}

variable "provider" {
  description = "provider"
}

variable "domain_name" {
  description = "A domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  type        = "list"
  description = "A list of domains that should be SANs in the issued certificate"
  default     = []
}

variable "zone_id" {
  description = "The ID of the hosted zone to contain this record."
}
