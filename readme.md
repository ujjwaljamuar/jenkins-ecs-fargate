# Jenkins on ECS Fargate with Lambda

This project deploys a Jenkins server on ECS Fargate, with Lambda functions for starting and stopping the Jenkins server. It uses API Gateway to trigger the Lambda functions.

## Project Structure
- `/terraform`: Contains all the Terraform configuration files.
- `/lambda-functions`: Contains the Lambda function code for starting and stopping Jenkins.
- `/scripts`: Contains a deployment script for easy deployment.
- `/docs`: Documentation files.

## How to Deploy
1. Configure your AWS credentials.
2. Run `scripts/deploy.sh` to deploy the infrastructure using Terraform.

## API Endpoints
- `POST /start`: Starts the Jenkins server.
- `POST /stop`: Stops the Jenkins server.

## Requirements
- AWS account
- Terraform
- AWS CLI
