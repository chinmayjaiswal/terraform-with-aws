resource "local_file" "my-pet" {
  filename = "pet-name.txt"
  content = "My pet is called finnegan!!"
}

resource "random_pet" "other-pet" {
  prefix="Mr"
  length="1"
  separator="."
}

