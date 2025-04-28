# terraform/modules/lambda/lambda_function.py

import json
import boto3

def lambda_handler(event, context):
    # Logic to trigger Jenkins
    client = boto3.client('ecs')

    # Start the ECS Fargate task
    response = client.run_task(
        cluster='jenkins-cluster',
        taskDefinition='jenkins-task',
        count=1,
        launchType='FARGATE',
        networkConfiguration={
            'awsvpcConfiguration': {
                'subnets': ['subnet-xxxxxx'],
                'assignPublicIp': 'ENABLED'
            }
        }
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Jenkins task triggered successfully!')
    }
