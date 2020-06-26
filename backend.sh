#!/bin/bash

set -e

BACKEND_FILE=$(mktemp -t "co.maur.modules")
STACK_NAME=${STACK_NAME:-terraform}

if [ -z "$STACK_ID" ]; then
	echo "Missing environment variable: STACK_ID"
	exit 1
fi

cat <<EOT >> $BACKEND_FILE
Description: AWS CloudFormation resources for Terraform backend
Parameters:
  StackID:
    Type: String
Resources:
  BackendBucket:
    Type: AWS::S3::Bucket
    Properties:
      AccessControl: Private
      BucketName: !Ref StackID
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
      TableName: !Ref StackID
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
	--stack-name $STACK_NAME \
	--template-file $BACKEND_FILE \
	--parameter-overrides StackID=$STACK_ID

rm $BACKEND_FILE
