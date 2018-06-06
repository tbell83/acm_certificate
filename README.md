
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| count |  | string | `1` | no |
| domain_name | A domain name for which the certificate should be issued | string | - | yes |
| subject_alternative_names | A list of domains that should be SANs in the issued certificate | list | `<list>` | no |
| tags |  | map | `<map>` | no |
| zone_id | The ID of the hosted zone to contain this record. | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate_arn |  |
