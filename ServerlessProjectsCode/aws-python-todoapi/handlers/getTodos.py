import json
import boto3
import uuid
from datetime import datetime
import os

dynamodb = boto3.resource("dynamodb",region_name=str(os.environ['Region']))
table = dynamodb.Table(str(os.environ['DYNAMODB_TABLE']))

def getTodos(event,context):
    response = table.scan()['Items']
    
    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }