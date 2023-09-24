import json
import boto3
import uuid
from datetime import datetime
import os

dynamodb = boto3.resource("dynamodb",region_name=str(os.environ['Region']))
table = dynamodb.Table(str(os.environ['DYNAMODB_TABLE']))

def createTodo(event,context):
    print(event)
    contents = json.loads(event['body'])
    content = contents['todo']

    if len(content) < 1:
        return{
            'statusCode': 200,
            'headers': {
                "Content-Type": "application/json"
            },
            'body': 'Please enter some data!'
        }        

    print(content)
    response = table.put_item(
       Item =  {
           'id': str(uuid.uuid4()),
           'todo': str(content),
           'checks': False,
           'createdAt': str(datetime.now()),
           'updatedAt': str(datetime.now())
       }
    )
    return{
        'statusCode': 200,
        'headers': {
            "Content-Type": "application/json"
        },
        'body': json.dumps(response)
    }