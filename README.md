# terraform-with-aws

Prerequisites:
* [Install terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)
* [optional] install [**tfenv**](https://github.com/tfutils/tfenv) tool to manage terraform versions

### Commands:
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


## Multi Providers in terrraform
* You can add multiple providers in same project. refer 10_local/multi_provider.tf
* To check count of total providers installed go to ```.terraform``` directory verify


## Variables in terraform
* Types of Variables
  * number
  * string
  * bool
  * map
  * list 
  * set
* Ways to define variable:
  * Using .auto.tfvars file
  * Using .auto.tfvars.json file
  * Using terraform.tfvars file
  * By providing command line flag of -var or -var-file
* command line flag of -var or -var-file has the highest precedence in variable definition
* To use  variables file (variables.tfvars) use following command : 
  * ```terraform apply -var-file variables.tfvars```
* Terraform follows a variable definition precedence order to determine the value and the command line flag of –var or –var-file takes the highest priority.
* 



