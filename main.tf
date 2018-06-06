resource "aws_acm_certificate" "certificate" {
  count                     = "${var.count}"
  provider                  = "${var.provider}"
  domain_name               = "${var.domain_name}"
  subject_alternative_names = ["${var.subject_alternative_names}"]
  validation_method         = "DNS"
  tags                      = "${var.tags}"
}

resource "aws_acm_certificate_validation" "validation" {
  count                   = "${var.count}"
  provider                = "${var.provider}"
  certificate_arn         = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = ["${aws_route53_record.validation_record.fqdn}"]
}

resource "aws_route53_record" "validation_record" {
  count    = "${var.count}"
  provider = "${var.provider}"
  name     = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_name}"
  type     = "${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_type}"
  zone_id  = "${var.zone_id}"
  records  = ["${aws_acm_certificate.certificate.domain_validation_options.0.resource_record_value}"]
  ttl      = 60
}
