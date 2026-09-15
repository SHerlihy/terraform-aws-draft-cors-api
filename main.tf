resource "aws_api_gateway_rest_api" "root" {
  name = var.api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = var.tags
}

resource "aws_api_gateway_resource" "any" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  parent_id   = aws_api_gateway_rest_api.root.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "preflight" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  resource_id = aws_api_gateway_resource.any.id
  http_method = "OPTIONS"

  authorization = "NONE"
}

resource "aws_api_gateway_integration" "preflight" {
  rest_api_id = aws_api_gateway_rest_api.root.id
  resource_id = aws_api_gateway_resource.any.id
  http_method = aws_api_gateway_method.preflight.http_method

  type = "MOCK"

  passthrough_behavior = "NEVER"

  request_templates = {
    "application/json" = "{\"statusCode\": 200}"
  }
}

resource "aws_api_gateway_method_response" "preflight" {
  depends_on = [
    aws_api_gateway_method.preflight,
    aws_api_gateway_integration.preflight
  ]

  rest_api_id = aws_api_gateway_rest_api.root.id
  resource_id = aws_api_gateway_resource.any.id
  http_method = aws_api_gateway_method.preflight.http_method
  status_code = "200"

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = true,
    "method.response.header.Access-Control-Allow-Methods" = true,
    "method.response.header.Access-Control-Allow-Origin"  = true
  }
}

resource "aws_api_gateway_integration_response" "preflight" {
  depends_on = [
    aws_api_gateway_method.preflight,
    aws_api_gateway_integration.preflight
  ]

  rest_api_id = aws_api_gateway_rest_api.root.id
  resource_id = aws_api_gateway_resource.any.id
  http_method = aws_api_gateway_method.preflight.http_method
  status_code = aws_api_gateway_method_response.preflight.status_code

  response_parameters = {
    "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,X-Amz-User-Agent'"
    "method.response.header.Access-Control-Allow-Methods" = "'DELETE,GET,HEAD,OPTIONS,PUT,POST,PATCH'",
    "method.response.header.Access-Control-Allow-Origin"  = "'*'"
  }
}
