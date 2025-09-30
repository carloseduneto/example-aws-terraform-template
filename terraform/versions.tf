terraform {
  backend "s3" {
    # Substitua pelos outputs do bootstrap
    bucket         = "ong-trabalho-gestao-qualidade-01-terraform"
    key            = "example-aws-terraform-template/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "example-aws-terraform-terraform-lock"
    encrypt        = true
  }

  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}


provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Environment = var.environment
      Project     = var.project_name
      ManagedBy   = "terraform"
      Repository  = "REPO_NAME"
    }
  }
}

resource "aws_s3_bucket" "this"{
  bucket = "bucket01"
}

resource "aws_dynamodb_table" "escola" {
  name         = "trabalho_escola"
  billing_mode = "PAY_PER_REQUEST"

  # Chave primária
  hash_key = "id"

  attribute {
    name = "id"
    type = "S" # S = String, N = Number, B = Binary
  }
}
