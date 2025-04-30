import json
import os
import boto3

ecs = boto3.client('ecs')

def lambda_handler(event, context):
    try:
        cluster_name = os.environ['CLUSTER_NAME']
        tasks = ecs.list_tasks(cluster=cluster_name)

        if not tasks['taskArns']:
            return {
                'statusCode': 200,
                'body': json.dumps({'message': 'No running Jenkins tasks found'})
            }

        for task_arn in tasks['taskArns']:
            ecs.stop_task(
                cluster=cluster_name,
                task=task_arn,
                reason='Automated stop after idle timeout'
            )

        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': 'Stopped Jenkins tasks',
                'tasks': tasks['taskArns']
            })
        }

    except Exception as e:
        print("Error stopping Jenkins task:", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps({'error': str(e)})
        }
