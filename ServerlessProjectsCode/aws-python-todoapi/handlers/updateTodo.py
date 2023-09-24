import json
import boto3
import uuid
from datetime import datetime
import os

dynamodb = boto3.resource("dynamodb",region_name=str(os.environ['Region']))
table = dynamodb.Table(str(os.environ['DYNAMODB_TABLE']))

def updateTodo(event,context):
    content = event['body']
    print(content)
    print((type(content)))
    #content = str(content).strip("'<>() ").replace('\'', '\"')
    try:
        json_content = json.loads(content)
    except json.JSONDecodeError as e:
        print(f"Error decoding JSON: {e}")
        return {"statusCode": 400, "body": "Invalid JSON format"}
    print(type(json_content))
    TodoId = event["pathParameters"]["id"]
    if (type(json_content['todo']) != str) or (type(json_content['checks']) != bool):
        return ("You have entered the wrong data type item for todo or checks!")

    table.update_item(
        Key={
            'id': TodoId
        },
        UpdateExpression='SET todo = :val1,checks = :val2,updatedAt = :val3',
        ExpressionAttributeValues={
            ':val1': json_content["todo"],
            ':val2': json_content["checks"],
            ':val3': str(datetime.now())
        }
    )

    return {
        'statusCode': 200,
        'body': f'values are updated for {TodoId}!'
    }