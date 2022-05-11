#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "paper_onboarding_policy" {
  name        = "${local.cluster_name}_paper_onboard_s3"
  path        = "/"
  description = "Policy, which allows Paper Onboarding cron to access S3"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:List*"
        ],
        "Resource" : ["arn:aws:s3:::origo-onboarding-*",
        "arn:aws:s3:::origo-onboarding-*/*"]
      },
    ]
  })
}
