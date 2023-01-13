# terraform-with-aws

Tools:
install **tfenv** tool to manage tfenv versions

Commands:
- ```tfenv list```
- ```tfenv exec init```
- ```terraform init```
- ```terraform plan```
- ```terraform apply```
- ```terraform apply --auto-approve``` : does not need confirmation
- ```terraform destroy ```
- ```terraform destroy --auto-approve``` : does not need confirmation

### Steps to run terraform script
Execute following commands to try this your own
1. ```cd 10_local``` : switch to terraform directory
2. ```terraform init``` : this will create .terraform folder in 10_local and .terraform.lock.hcl file
3. ```terraform plan``` : this will show you resources being created
4. ```terraform apply``` : this will create resources defined in terraform file (asks confirmation before creation)
5. ```terraform apply --auto-approve``` : creates resources without confirmation
6. ```terraform destroy ``` : to remove resources created
