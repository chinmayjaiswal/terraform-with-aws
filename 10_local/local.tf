#This terraform script creates simple file
resource "local_file" "hello_terraform" {
  filename = "hello.txt"
  content = "Welcome to terraform!! This file is created using terraform. Provider local and ResourceType: local_file and ResourceName: hello_terraform "
}

resource "local_sensitive_file" "sensitive_content" {
  filename = "sensitive_content.txt"
  content = "Welcome to terraform!! This file is created using terraform. Provider local and ResourceType: local_file and ResourceName: hello_terraform "
}

