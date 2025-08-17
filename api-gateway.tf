resource "aws_apigatewayv2_api" "api_gateway" {
  name            = "example-http-api"
  protocol_type   = "HTTP"
  ip_address_type = "ipv4"

  cors_configuration {
    allow_origins = "*"
    allow_headers = "content-type"
    allow_methods = "GET"
  }
}
resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id             = aws_apigatewayv2_api.api_gateway.id
  integration_type   = "AWS_PROXY"
  connection_type    = "INTERNET"
  integration_method = "GET"
  integration_uri    = aws_lambda_function.lambda.invoke_arn
}

resource "aws_apigatewayv2_route" "api_gateway_route" {
  api_id    = aws_apigatewayv2_api.api_gateway.id
  route_key = "GET /jogo"
  target    = "integrations/${aws_apigatewayv2_integration.api_gateway_integration.id}"
}
resource "aws_apigatewayv2_stage" "api_gateway_stage" {
  api_id      = aws_apigatewayv2_api.api_gateway.id
  name        = "prod"
  auto_deploy = true
}
