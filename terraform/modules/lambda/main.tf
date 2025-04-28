# terraform/modules/lambda/main.tf

resource "aws_lambda_function" "start_jenkins" {
  function_name = "StartJenkins"
  role          = var.lambda_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
  filename      = "terraform/modules/lambda/start-jenkins/lambda_function.zip"
}

resource "aws_lambda_function" "stop_jenkins" {
  function_name = "StopJenkins"
  role          = var.lambda_role
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.8"
  timeout       = 30
  filename      = "terraform/modules/lambda/stop-jenkins/lambda_function.zip"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = "jenkins-api"
  description = "API to start/stop Jenkins Lambda"
}

resource "aws_api_gateway_resource" "root_start" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "start"
}

resource "aws_api_gateway_resource" "root_stop" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "stop"
}

resource "aws_api_gateway_method" "start_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.root_start.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "stop_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.root_stop.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "start_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.root_start.id
  http_method             = aws_api_gateway_method.start_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.start_jenkins.arn}/invocations"
}

resource "aws_api_gateway_integration" "stop_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.root_stop.id
  http_method             = aws_api_gateway_method.stop_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${data.aws_region.current.name}:lambda:path/2015-03-31/functions/${aws_lambda_function.stop_jenkins.arn}/invocations"
}

resource "aws_lambda_permission" "allow_api_gateway_start" {
  statement_id  = "AllowAPIGatewayInvokeStart"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.start_jenkins.function_name
}

resource "aws_lambda_permission" "allow_api_gateway_stop" {
  statement_id  = "AllowAPIGatewayInvokeStop"
  action        = "lambda:InvokeFunction"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.stop_jenkins.function_name
}
