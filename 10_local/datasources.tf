data "local_file" "externalFile" { #note: we use  'data' block instead of `resource` block to point to external resource
  filename = "externalResource.txt"
}

output "content_of_external_resource" {
  value = data.local_file.externalFile.content
}

#To verify details :
#run: terraform init
#run: terraform plan
#run: terraform apply
#run: terraform state show data.local_file.externalFile
#run: terraform output content_of_external_resource
