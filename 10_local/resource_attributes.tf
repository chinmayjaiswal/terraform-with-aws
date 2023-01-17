resource "time_static" "time" {

}

resource "local_file" "resource_attribute_example" {
  filename = "./target/resourceAttributeExample.txt"
  content = "This file is created at ${time_static.time.id}"
}