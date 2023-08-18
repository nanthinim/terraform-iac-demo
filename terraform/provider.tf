provider "aws" {

  #checkov:skip=CKV_AWS_41:The bucket is a public static content host 
  #  profile = "${var.awsprofile}"
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket  = terraform.bucket
    key     = "${terraform.key}/app.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
