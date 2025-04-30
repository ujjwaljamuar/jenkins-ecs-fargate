resource "aws_apigatewayv2_api" "jenkins_trigger" {
  name          = "JenkinsTriggerAPI"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_integration" "start_lambda_integration" {
  api_id           = aws_apigatewayv2_api.jenkins_trigger.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.start_jenkins.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "start_route" {
  api_id    = aws_apigatewayv2_api.jenkins_trigger.id
  route_key = "POST /start"
  target    = "integrations/${aws_apigatewayv2_integration.start_lambda_integration.id}"
}

resource "aws_lambda_permission" "apigw_start" {
  statement_id  = "AllowAPIGatewayInvokeStart"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.start_jenkins.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.jenkins_trigger.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "stop_lambda_integration" {
  api_id           = aws_apigatewayv2_api.jenkins_trigger.id
  integration_type = "AWS_PROXY"
  integration_uri  = aws_lambda_function.stop_jenkins.invoke_arn
  integration_method = "POST"
  payload_format_version = "2.0"
}

resource "aws_apigatewayv2_route" "stop_route" {
  api_id    = aws_apigatewayv2_api.jenkins_trigger.id
  route_key = "POST /stop"
  target    = "integrations/${aws_apigatewayv2_integration.stop_lambda_integration.id}"
}

resource "aws_lambda_permission" "apigw_stop" {
  statement_id  = "AllowAPIGatewayInvokeStop"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.stop_jenkins.arn
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.jenkins_trigger.execution_arn}/*/*"
}

resource "aws_apigatewayv2_stage" "api_stage" {
  api_id      = aws_apigatewayv2_api.jenkins_trigger.id
  name        = "$default"
  auto_deploy = true
}