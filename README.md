# Draft API with CORS

Draft a public API with OPTIONS endpoint for CORS.

Please see sister module responsible for deploying the API:
https://github.com/SHerlihy/terraform-aws-deploy-api-public-quota

## Example Usage

For comprehensive usage cases see:
https://github.com/SHerlihy/test_module_quota_api

### Multiple Deployments

```
module "draft_apis" {
  providers = {
    aws = aws.product_role
  }

  for_each = local.api_names
  source  = "SHerlihy/draft-cors-api/aws"
  version = "0.0.1"

  api_name = each.value
  tags     = local.tags
}
```
