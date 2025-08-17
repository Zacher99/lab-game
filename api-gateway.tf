resource "aws_apigatewayv2_api" "api_gateway" {
  name            = "api-matheuszacher"
  protocol_type   = "HTTP"
  ip_address_type = "ipv4"

  cors_configuration {
    allow_origins = ["*"]
    allow_headers = ["content-type"]
    allow_methods = ["GET"]
  }
}
resource "aws_apigatewayv2_integration" "api_gateway_integration" {
  api_id                 = aws_apigatewayv2_api.api_gateway.id
  integration_type       = "AWS_PROXY"
  connection_type        = "INTERNET"
  integration_method     = "POST"
  integration_uri        = aws_lambda_function.lambda.invoke_arn
  payload_format_version = "2.0"
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
resource "aws_lambda_permission" "lambda_permission_api_gateway" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name
  principal     = "apigateway.amazonaws.com"

  source_arn = "${aws_apigatewayv2_api.api_gateway.execution_arn}/*/*"
}
