# Input Variables
# https://opentofu.org/docs/language/values/variables

variable "namespaces" {
  type = map(any)
}

variable "project" {
  type = string
}
