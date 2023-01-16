resource "local_file" "my-pet" {
  filename = "./target/pet-name.txt"
  content = "My pet is called finnegan!!"
}

resource "random_pet" "other-pet" {
  prefix="Mr"
  length="1"
  separator="."
}

resource "local_file" "iac_code" {
  filename = "./target/practice"
  content = "Setting up infrastructure as code"
}

resource "random_string" "iac_random" {
  length = 10
  min_upper = 5
}