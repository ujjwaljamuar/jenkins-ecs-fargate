import json
import boto3

ecs_client = boto3.client('ecs')

def lambda_handler(event, context):
    # Stop the ECS Fargate service (Jenkins)
    response = ecs_client.update_service(
        cluster='jenkins-cluster',
        service='jenkins-service',
        desiredCount=0  # Stop the Jenkins service
    )
    
    return {
        'statusCode': 200,
        'body': json.dumps('Jenkins stopped!')
    }
