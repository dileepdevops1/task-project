#
# QA7 backend.tf
#
###############################################################################
#
# The backend setup is defined via the 'Account Module' which can be seen in
# GitHub here: https://github.com/Chewy-Inc/terraform-aws-account-module
#
# Once you have bootstrapped the account with the Account Module you will be
# able to use the below backend.
#
# You will need to change the "XXXXXXXX" sections to their appropriate values.
#
# This requires you to do a `terraform init` and will automatically migrate your
# tfstate file to the new bucket.
#
terraform {
  required_version = "0.12.7"

  backend "s3" {
    bucket         = "test"
    dynamodb_table = "terraform"
    encrypt        = true
    profile        = var.profile
    key            = "state/test.tfstate"
    region         = "us-east-1"
  }
}