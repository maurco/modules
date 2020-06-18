#!/bin/bash

set -e

BACKEND_FILE=$(mktemp -t "co.maur.modules")

if [ -z "$NAME" ]; then
	echo "Missing environment variable: NAME"
	exit 1
fi

cat <<EOT >> $BACKEND_FILE
Description: AWS CloudFormation resources for Terraform backend
Resources:
  BackendBucket:
    Type: AWS::S3::Bucket
    Properties:
      AccessControl: Private
      BucketName: !Ref AWS::StackName
      VersioningConfiguration:
        Status: Enabled
      LifecycleConfiguration:
        Rules:
        - Status: Enabled
          NoncurrentVersionExpirationInDays: 90
      BucketEncryption:
        ServerSideEncryptionConfiguration:
        - ServerSideEncryptionByDefault:
            SSEAlgorithm: AES256
      PublicAccessBlockConfiguration:
        BlockPublicAcls: true
        BlockPublicPolicy: true
        IgnorePublicAcls: true
        RestrictPublicBuckets: true
  BackendTable:
    Type: AWS::DynamoDB::Table
    Properties:
      TableName: !Ref AWS::StackName
      BillingMode: PAY_PER_REQUEST
      KeySchema:
        - KeyType: HASH
          AttributeName: LockID
      AttributeDefinitions:
        - AttributeType: S
          AttributeName: LockID
EOT

aws cloudformation deploy \
	--no-fail-on-empty-changeset \
	--template-file $BACKEND_FILE \
	--stack-name $NAME

rm $BACKEND_FILE
