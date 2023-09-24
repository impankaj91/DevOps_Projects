import json
import boto3

client = boto3.client('ses')

def contactUs(event, context):
    data = json.loads(event['body'])
    print(data)
    try:
        ToAddress = data['To']
        FromAddress = data['From']
        message = data['Message']
        subject = data['Subject']
        response = client.send_email(
            Source = FromAddress,
            Destination = {
            'ToAddresses': [ToAddress],
            },
            Message={
                'Subject': {
                    'Data': subject
                },
                'Body': {
                    'Text': {
                        'Data': message
                    },
                }
            },
        )

        return {
            "statusCode": 200,
            "body": "Email Sent Successfully!",
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json"
            }
        }
    except KeyError:
        return {
            "statusCode": 400,
            "body": "To,From,Message,Subject One of thing is missing!!",
        }
    except:
        return {
            "statusCode": 400,
            "body": "Email Failure!",
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json"
            }
        }
    