resource "aws_s3_bucket" "onboarding" {
  bucket = "pdp-onboarding-${var.environment_name}"
  acl    = "private"
}