#!/bin/sh

set -e


AWS_REGION=${AWS_REGION:-}
SSM_ACTIVATION=$(aws ssm create-activation --default-instance-name "fargate-ssm" --iam-role "service-role/AmazonEC2RunCommandRoleForManagedInstances" --registration-limit 1 --region $AWS_REGION)

export SSM_ACTIVATION_CODE=$(echo $SSM_ACTIVATION | jq -r .ActivationCode)
export SSM_ACTIVATION_ID=$(echo $SSM_ACTIVATION | jq -r .ActivationId)

amazon-ssm-agent -register -code $SSM_ACTIVATION_CODE -id $SSM_ACTIVATION_ID -region $AWS_REGION

amazon-ssm-agent & go run main.go

exec "$@"