import json
import boto3
import uuid
from datetime import datetime
import os

dynamodb = boto3.resource("dynamodb",region_name=str(os.environ['Region']))
table = dynamodb.Table(str(os.environ['DYNAMODB_TABLE']))

def getTodo(event,context):
    TodoId = event["pathParameters"]["id"]
    response = table.get_item(
        Key = {
            'id': TodoId
        }
    )
    try:
        data = response['Item']
        #print(data)
        return {
                'statusCode': 200,
                'body': json.dumps(data)
            }
    except:
        return {
            'statusCode': 404,
            'body': 'Todo not Found!'
        }