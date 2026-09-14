output "api_id" {
  value = aws_api_gateway_rest_api.root.id
}

output "root_resource_id" {
  value = aws_api_gateway_rest_api.root.root_resource_id
}

output "execution_arn" {
  value = aws_api_gateway_rest_api.root.execution_arn
}

output "proxy_id" {
  value = aws_api_gateway_resource.proxy.id
}

output "proxy_method" {
  value = aws_api_gateway_method.proxy_any.http_method
}
