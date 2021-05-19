#!/usr/bin/python3
import boto3
import subprocess
import sys
import json

profile = str(sys.argv[1])
region = str(sys.argv[2])
ec2name = str(sys.argv[3])

session = boto3.session.Session(profile_name=profile)
client = session.client('ec2',region_name=region)


response = client.describe_instances(
    Filters=[
        {
            'Name': 'tag:Name',
            'Values': [
                ec2name,
            ]
        },
    ],
)

if bool(response['Reservations']):
    if 'PublicIpAddress' in response['Reservations'][0]['Instances'][0].keys():
        print(response['Reservations'][0]['Instances'][0]['PublicIpAddress'])
    else:
        print('[ERROR] Found no Public IP for host')
else:
    print('[ERROR] COULD NOT FIND HOST')