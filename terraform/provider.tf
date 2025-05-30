# setup aws terraform provider version to be used
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.6.2"
    }
  }
}

# setup terraform aws provider to create resources in your desired aws region
provider "aws" {
  region = var.region
}