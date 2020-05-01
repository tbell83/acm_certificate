locals {
  domain_root = join(".", [
    element(split(".", var.domain_name), 1),
    element(split(".", var.domain_name), 2)
  ])
}
