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
- ```terraform show [-json]``` : Display information about existing resources created and output variable values. Add -json flag to show in json format
- ```terraform output``` : display values for all output variables
- ```terraform output <variable_name>``` Display value of specific output variable
- ```terraform validate``` : to verify if configuration files have valid syntax
- ```terraform fmt``` : formats code in canonical format
- ```terraform providers```:  see the providers required by current configuration directory
- ```terraform providers mirror </destinatino/directory>``` copy providers to destination directory
- ```terraform refresh```: updates state file as per resources modified outside terraform. Helps in identifying changes
- ```terraform graph``` : used to create visual representation of terraform resources in as graph structure. You can use any graph visualizer tool(graphviz) to display graph from this command output.
- ```terraform state show <resource.resource>``` : Display information about specific resource

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
* We should never attempt to manually edit state file ourselves (if needed use ```terraform state``` commands)

## Mutable vs Immutable Infrastructure
1. The word ‘mutable’ suggests the ability to change- to mutate into something new. In the DevOps world, the advantage of mutability is crucial when you wish to retain previous data without worrying about obtaining new infrastructure. You can apply patches, upgrade or downgrade, and scale up and down.
2. “Immutable” is the state of being unchangeable. It’s an antonym to mutable, which means that on this end, the infrastructure cannot be modified once deployed

## Lifecycle Rules

Example:
* You can set rules as per your use case. 
* For Example: following rule creates file first before destroying existing one during modifications
```
lifecycle {
    create_before_destroy = true
 }

```

* If you don't want to destroy resource then use : ```prevent_destroy=true``` in lifecycle block
  ```
      lifecycle {
      prevent_destroy=true
   }
  ```
* if you want to ignore changes you can add attribute ```ignore_changes=[<resource_attribute_to_ignore>]```. 
  * Example 
  ```
  lifecycle {
      ignore_changes = [tags] # ignores tags
      ignore_changes = [tags, ami]
      ignore_changes = all # ignore any changes to resource 
   }
  ```

* Example: All the resources for the ```random``` provider can be recreated by using a map type argument called ```keepers```. A change in the value will force the resource to be recreated.

## Datasources in terraform
* Datasources in terraform are used to refer to resources which are created externally which are not managed by terraform. 
* Datasoruces are defined by ```data``` block in terraform script
* Example: 
  ```
  data "aws_ami" "example" {
    most_recent = true
  
    owners = ["self"]
    tags = {
      Name   = "app-server"
      Tested = "true"
    }
  }
  ```

| Resource                                  | Data Source                | 
|-------------------------------------------|----------------------------|
| keyword: **resource**                     | Keyword: data              |
| Creates,Updates, Destroys, Infrastructure | Only Reads Infrastructure  |
| Also called Managed Resources             | Also called Data Resources |

### Hands-on:
* go to `10_local/datasources.tf` read configuration
* execute `terraform plan` and `terraform apply` commands
* execute `terraform state show data.local_file.externalFile` 
* execute `terraform output content_of_external_resource` 



## Meta argument
* Meta arguments are used in any `resource` block to change the behaviour of resources.
* We already used meta arguments while creating resources such as : `depends_on` and `lifecycle`
  * Few more Examples : `count`, `provider`, `provisioner`, `output`, `connection`, `variable`, `locals`, `timeouts`, `source`, `condition`, `data`, `for_each`, `on_failure`, `ignore_changes`, `create_before_destroy`, `validate`, `metadata`, `destroy`, `override`
  * Mor more details on these meta-arguments in refer [this-blog](https://medium.com/@neonforge/meta-arguments-in-terraform-unlocking-the-full-potential-of-infrastructure-as-code-de125c85c547)

### 1. Count
This meta argument is used to create multiple instances of same resource.
Example: 
```
resource "local_file" "foo"{
  filename= var.filename
  count=3
}

```
* Tip: * Tip: Resources created with `count` are maintained as list in state-file, this implies changing order of input variable to resource may replace existing resources

### 1. for_each
* Multiple instances of same resource can be created with `for_each` as well. 
* `for_each` works with only `map` or `set`
* Example: 
```
resource "local_file" "bar"{
  filename= each.value
  for_each=var.filenames #filenames should be set/map
}
```
* Tip: Resources created with `for_each` are maintained as map in state-file. Any modifications to input variable will not force replace other instance




