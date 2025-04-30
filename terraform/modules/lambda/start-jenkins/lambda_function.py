import json
import os
import boto3

ecs = boto3.client('ecs')

def lambda_handler(event, context):
    try:
        cluster_name = os.environ['CLUSTER_NAME']
        task_def = os.environ['TASK_DEFINITION']
        subnets = os.environ['SUBNET_IDS'].split(',')
        security_groups = [os.environ['SECURITY_GROUP_IDS']]

        response = ecs.run_task(
            cluster=cluster_name,
            launchType='FARGATE',
            taskDefinition=task_def,
            count=1,
            networkConfiguration={
                'awsvpcConfiguration': {
                    'subnets': subnets,
                    'securityGroups': security_groups,
                    'assignPublicIp': 'ENABLED'
                }
            }
        )

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Jenkins task started',
                'taskArn': response['tasks'][0]['taskArn'] if response.get('tasks') else 'No task started'
            })
        }

    except Exception as e:
        print("Error starting Jenkins task:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
