locals {
  api_url = "${aws_apigatewayv2_stage.api_gateway_stage.invoke_url}/jogo"
}
