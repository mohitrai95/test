#------------------------------------------------------------------------------
# Provider file
#------------------------------------------------------------------------------
provider "aws" {
  shared_credentials_files = ["$HOME/.aws/credentials"] # aws credentials are stored in this path
  region                   = "us-east-1"
}
