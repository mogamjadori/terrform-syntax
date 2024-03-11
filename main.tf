# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

variable "envs" {
  type    = list(string)
  default = ["dev", "prd", ""]
}

module "personal_custom_vpc" {
  for_each = toset([for s in var.envs : s if s != ""])
  source   = "./custom_vpc"
  env      = each.key
}
