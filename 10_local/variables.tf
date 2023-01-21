variable "name" {
  type    = string
  default = "Mark"

}
variable "number" {
  type    = bool
  default = true

}
variable "distance" {
  type    = number
  default = 5

}
variable "jedi" {
  type = map(string)
  default = {
    filename = "./target/first-jedi.txt"
    content  = "phanius"
  }

}

variable "gender" {
  type    = list(string)
  default = ["Male", "Female"]
}
variable "hard_drive" {
  type = map(string)
  default = {
    slow = "HHD"
    fast = "SSD"
  }
}
variable "users" {
  type    = set(string)
  default = ["tom", "jerry", "pluto", "daffy", "donald", "jerry", "chip", "dale"]
}