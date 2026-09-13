# terraform-aws-draft-cors-api

Draft a public API with OPTIONS endpoint for CORS.

Please see sister module responsible for deploying the API:
https://registry.terraform.io/modules/SHerlihy/deploy-api-public-quota/aws/latest

## Prerequisites
- An active AWS Account configured with appropriate IAM permissions.
- Terraform `~> 1.5`

## Example

For comprehensive usage cases see:
https://github.com/SHerlihy/test_module_quota_api

```hcl
module "draft_api" {
  source  = "SHerlihy/draft-cors-api/aws"
  version = "0.0.1"

  api_name = var.api_name
  tags     = var.tags
}
```
