terraform {
  backend "s3" {
    bucket         = "collms-tfstate-sj-2608"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "collms-tf-locks"
    encrypt        = true
  }
}