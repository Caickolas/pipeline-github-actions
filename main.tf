terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16.2"
    }

    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "3.72.0"
    # }
  }

  backend "s3" {
    bucket = "danielgil-remote-state-caickolas"
    key    = "pipeline-github-actions/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner      = "caickgalvao"
      managed-by = "terraform"
    }
  }
}

# provider "azurerm" {
#   features {}
# }

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "danielgil-remote-state-caickolas"
    key    = "aws-vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

# data "terraform_remote_state" "vnet" {
#   backend = "azurerm"
#   config = {
#     resource_group_name  = "rg-terraform-state"
#     storage_account_name = "caickgalvaocurso"
#     container_name       = "container-curso-terraform"
#     key                  = "azure-vnet/terraform.tfstate"
#   }
# }