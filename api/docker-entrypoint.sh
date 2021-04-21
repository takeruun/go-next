#!/bin/bash

set -e

export AWS_REGION=${AWS_REGION}
export AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}
export AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY}

SSM_ACTIVATION=$(aws ssm create-activation --default-instance-name "fargate-ssm" --iam-role "service-role/AmazonEC2RunCommandRoleForManagedInstances" --registration-limit 1 --region $AWS_REGION)

export SSM_ACTIVATION_CODE=$(echo $SSM_ACTIVATION | jq -r .ActivationCode)
export SSM_ACTIVATION_ID=$(echo $SSM_ACTIVATION | jq -r .ActivationId)

amazon-ssm-agent -register -code $SSM_ACTIVATION_CODE -id $SSM_ACTIVATION_ID -region $AWS_REGION

amazon-ssm-agent & go run main.go

exec "$@"