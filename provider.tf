provider "aws" {
  region = "${var.provider}"
}

provider "aws" {
  alias  = "zone_owner"
  region = "${var.provider}"
}

provider "aws" {
  alias  = "cert_owner"
  region = "${var.provider}"
}
