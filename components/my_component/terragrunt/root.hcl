romote_state {
  backend = "s3"
  

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket = "clive-infra-state-files"

    key = "tofu.tfstate"
    region = "us-east-1"
    encrypt = true 
    dynamodb_table = "clive-infra-lock-table"
  }
}

generate "provider" {
  path = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
  provider = "aws" {
    region = "us-east-1"
  }
  EOF
}