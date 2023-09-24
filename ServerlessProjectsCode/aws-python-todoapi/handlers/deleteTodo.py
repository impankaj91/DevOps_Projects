import json
import boto3
import uuid
from datetime import datetime
import os

dynamodb = boto3.resource("dynamodb",region_name=str(os.environ['Region']))
table = dynamodb.Table(str(os.environ['DYNAMODB_TABLE']))

def deleteTodo(event,context):
    TodoId = event["pathParameters"]["id"]
    response = table.delete_item(
        Key = {
            'id': TodoId
        }
    )

    return {
        'statusCode': 200,
        'body': 'Item deleted!!'
    }

