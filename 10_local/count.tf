#following resource block will create multiple files based on variable filenames and its size
resource "local_file" "foo" {
  filename = var.fileNames[count.index]
  content  = "abc"
  count    = length(var.fileNames) #length is built-in function provided by terraform
}
output "foo_files" {
  value = local_file.foo
  sensitive = true
}
