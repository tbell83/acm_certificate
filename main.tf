resource "aws_acm_certificate" "certificate" {
  count                     = var.cross_account == "false" ? var.mod_count : 0
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags                      = var.tags

  options {
    certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  }
}

resource "aws_acm_certificate_validation" "validation" {
  count                   = var.cross_account == "false" ? var.mod_count : 0
  certificate_arn         = join("", aws_acm_certificate.certificate.*.arn)
  validation_record_fqdns = [join("", aws_route53_record.validation_record.*.fqdn)]
}

resource "aws_route53_record" "validation_record" {
  count   = var.cross_account == "false" ? var.mod_count : 0
  name    = join("", aws_acm_certificate.certificate.*.domain_validation_options.0.resource_record_name)
  type    = join("", aws_acm_certificate.certificate.*.domain_validation_options.0.resource_record_type)
  records = [join("", aws_acm_certificate.certificate.*.domain_validation_options.0.resource_record_value)]
  zone_id = join("", data.aws_route53_zone.zone.*.zone_id)
  ttl     = 60
}

data "aws_route53_zone" "zone" {
  count = var.cross_account == "false" ? var.mod_count : 0
  name  = var.domain_root
}

# Resources if Route53 Zone and ACM Certificate are not in the same AWS account
resource "aws_acm_certificate" "certificate_xaccount" {
  count                     = var.cross_account == "true" ? var.mod_count : 0
  provider                  = aws.cert_owner
  domain_name               = var.domain_name
  subject_alternative_names = var.subject_alternative_names
  validation_method         = "DNS"
  tags                      = var.tags

  options {
    certificate_transparency_logging_preference = var.certificate_transparency_logging_preference
  }
}

resource "aws_acm_certificate_validation" "validation_xaccount" {
  count                   = var.cross_account == "true" ? var.mod_count : 0
  provider                = aws.cert_owner
  certificate_arn         = join("", aws_acm_certificate.certificate_xaccount.*.arn)
  validation_record_fqdns = [join("", aws_route53_record.validation_record_xaccount.*.fqdn)]
}

resource "aws_route53_record" "validation_record_xaccount" {
  count    = var.cross_account == "true" ? var.mod_count : 0
  provider = aws.zone_owner
  name     = join("", aws_acm_certificate.certificate_xaccount.*.domain_validation_options.0.resource_record_name)
  type     = join("", aws_acm_certificate.certificate_xaccount.*.domain_validation_options.0.resource_record_type)
  records  = [join("", aws_acm_certificate.certificate_xaccount.*.domain_validation_options.0.resource_record_value)]
  zone_id  = join("", data.aws_route53_zone.zone_xaccount.*.zone_id)
  ttl      = 60
}

data "aws_route53_zone" "zone_xaccount" {
  count    = var.cross_account == "true" ? var.mod_count : 0
  name     = var.domain_root
  provider = aws.zone_owner
}
