locals {
  domain_root = "${
		join(".",
			list(	
				element(split(".", var.domain_name), 1),
				element(split(".", var.domain_name), 2)
			)
		)
	}"
}
