output=`aws ecs describe-services --cluster go-next-cluster --services go-next-service | jq ".services[0].networkConfiguration"`

subnets=`echo $output | jq -r '.awsvpcConfiguration.subnets|join(",")'`
echo $subnets
securityGroups=`echo $output | jq -r '.awsvpcConfiguration.securityGroups|join(",")'`
echo $securityGroups
assignPublicIp=`echo $output | jq -r '.awsvpcConfiguration.assignPublicIp'`

aws ecs run-task \
  --cluster go-next-cluster \
  --task-definition go-next-task \
  --network-configuration "awsvpcConfiguration={subnets=[${subnets}],securityGroups=[${securityGroups}],assignPublicIp=${assignPublicIp}}"