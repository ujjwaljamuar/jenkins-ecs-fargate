# terraform/modules/lambda/stop-jenkins/lambda_function.py

import json
import boto3

def lambda_handler(event, context):
    client = boto3.client('ecs')

    response = client.list_tasks(
        cluster='jenkins-cluster',  # Replace with your ECS cluster name
        family='jenkins-task',  # Replace with your ECS task family name
        desiredStatus='RUNNING'
    )

    if len(response['taskArns']) > 0:
        task_arn = response['taskArns'][0]  # Stop the first running task
        stop_response = client.stop_task(
            cluster='jenkins-cluster',  # Replace with your ECS cluster name
            task=task_arn
        )
        return {
            'statusCode': 200,
            'body': json.dumps('Jenkins task stopped successfully!')
        }
    else:
        return {
            'statusCode': 400,
            'body': json.dumps('No running Jenkins task found.')
        }
