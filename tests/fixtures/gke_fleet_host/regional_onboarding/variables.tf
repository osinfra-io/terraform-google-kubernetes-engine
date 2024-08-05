# Input Variables
# https://www.terraform.io/language/values/variables

variable "namespaces" {
  type = map(any)
}

variable "project" {
  type = string
}
