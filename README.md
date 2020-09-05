# octopus-ecs

## Requirements
* (Terragrunt)[https://github.com/gruntwork-io/terragrunt]
* (Terraform)[https://www.terraform.io/]
* (AWS CLI)[https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html]

## Provision octopus server
```bash
cd ./environments/dev/eu-central-1/octopus-server
terragrunt apply-all
```

## Get Master Key
```bash
ssh ec2-user@<ec2_ip_address>
docker exec -it <octopus_server_container_id> ./Octopus.Server show-master-key
```

## Links
* (cogini/multi-env-deploy)[https://github.com/cogini/multi-env-deploy]
* (gruntwork-io/terragrunt-infrastructure-live-example)[https://github.com/gruntwork-io/terragrunt-infrastructure-live-example]