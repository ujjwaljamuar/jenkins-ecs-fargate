output "start_lambda_api_endpoint" {
  description = "API Gateway endpoint to trigger Jenkins start"
  value       = "${aws_apigatewayv2_api.jenkins_trigger.api_endpoint}/start"
}

output "stop_lambda_api_endpoint" {
  description = "API Gateway endpoint to trigger Jenkins stop"
  value       = "${aws_apigatewayv2_api.jenkins_trigger.api_endpoint}/stop"
}