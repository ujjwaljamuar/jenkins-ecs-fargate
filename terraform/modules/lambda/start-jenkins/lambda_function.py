# terraform/modules/lambda/start-jenkins/lambda_function.py

import json
import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')

    response = client.run_task(
        cluster='jenkins-cluster',  # Replace with your ECS cluster name
        taskDefinition='jenkins-task',  # Replace with your task definition
        count=1,
        launchType='FARGATE',
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': ['subnet-xxxxxx'],  # Replace with your subnet IDs
                'assignPublicIp': 'ENABLED'
            }
        }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Jenkins task started successfully!')
    }
