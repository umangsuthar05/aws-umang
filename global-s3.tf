terraform {
  backend "s3" {
      bucket = "terraform-aws-infrastructure"
      key =    "state/ap-southeast-1/apps/demo"
      region = "ap-southeast-1"
      access_key = "demo"
      secret_key = "demo"

}
}
resource "aws_s3_bucket" "terraform-aws-infrastructure" {
  bucket = "terraform-aws-infrastructure"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}