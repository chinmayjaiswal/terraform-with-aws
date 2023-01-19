# Terraform Basics

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
- ```terraform show``` : Display information about existing resources created and output variable values
- ```terraform output``` : display values for output variables

### Steps to run terraform script in this repository
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

## Resource Dependency
* Refer ```10_local/implicit_and_explicit_dependency.tf``` in repository
* Implicit dependency : When we use reference expressions to link resources
  * Example: Resource A is created by referring Resource B's Attribute. 
    ```content = "This file is created at ${time_static.time.id}"```
* Explicit Dependency : by explicitly mentioning dependency with ```depends_on``` block in Resource
  * Example:
    * ``` depends_on =[local_file.krill] ```

## Output variables
* output variables are used to store value of expressions in variables
```
output "<variable_name>" {
  value="<variable_value>"  #this is mandatory attribute and should be reference variable
  <arguments>
 }
```
* use ```terraform output``` command to print all output variables value
* use ```terraform output <output_variable_name>``` to print specific output variable value

## Terraform State
* Default Terraform state filename is : ```terraform.tfstate``` and it is stored as ``json`` format by default
* We cannot disable state in terraform (its non-optinoal feature in terraform)
* ```terraform init``` command does not refresh state
* Until you run ```terraform apply``` state file will not be created
### **Considerations in terraform state file**
* Terraform state file contains sensitive information about resources
* It is not  recommended to store state file in version control repositories
* Store state file in remote state backends such as s3, terraform cloud
* We should never attempt to manually edit state file ourselves (if needed use ```terraform state commands```)





