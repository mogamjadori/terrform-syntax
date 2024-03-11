terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-2"
}

variable "names" {
  type    = list(string)
  default = ["최시은", "변의주"]
}

module "personal_custom_vpc" {
  for_each = toset(var.names)
  source   = "./custom_vpc"
  env      = "personal_${each.key}"
}
