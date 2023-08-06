import json
import logging
from argparse import ArgumentParser

import boto3
from botocore.exceptions import ClientError

with open('credentials.json', 'r') as fd:
    credentials = json.loads(fd.read())

def create_s3_client():
    return boto3.client('s3',
        endpoint_url=credentials.get('endpoint_url'),
        aws_access_key_id=credentials.get('access_key'),
        aws_secret_access_key=credentials.get('secret_key'),
    )

def create_bucket(bucket_name):
    s3 = create_s3_client()
    try:
        s3.create_bucket(Bucket=bucket_name)
        print("Bucket [{}] has been created.".format(bucket_name))
    except ClientError as e:
        logging.error(e)
    else:
        list_buckets()

def list_buckets():
    try:
        s3 = create_s3_client()
        response = s3.list_buckets()
        print('--Existing buckets--')
        for bucket in response['Buckets']:
            print(bucket['Name'])

    except ClientError as e:
        logging.error(e)

def delete_bucket(bucket_name):
    s3 = create_s3_client()
    try:
        s3.delete_bucket(Bucket=bucket_name)
        print("Bucket [{}] has been deleted.".format(bucket_name))
    except ClientError as e:
        logging.error(e)
    else:
        list_buckets()

def main():
    parser = ArgumentParser(description='Manage S3 buckets')
    parser.add_argument('--action',
                        dest='action',
                        action='store',
                        required=True,
                        choices=['create', 'list', 'delete'],
                        help='the action to perform (create, list, delete)')

    parser.add_argument('--bucket-name',
                        dest='bucket_name',
                        action='store',
                        required=True,
                        help='the name of the bucket')

    args = parser.parse_args()

    if args.action == 'list':
        list_buckets()
    elif args.action == 'create':
        create_bucket(args.bucket_name)
    elif args.action == 'delete':
        delete_bucket(args.bucket_name)

if __name__ == "__main__":
    main()
