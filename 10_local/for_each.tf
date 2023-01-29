#this block uses for_each meta-argument to create multiple instances of resource local_file
resource "local_file" "cartoonCharacters" {
  for_each = var.cartoonCharacterFileNames
  filename = each.value
  content = "this file is : ${each.value}"
  file_permission = "400"
}