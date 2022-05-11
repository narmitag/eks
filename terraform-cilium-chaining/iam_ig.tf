#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "ig_policy" {
  name        = "${local.cluster_name}_ig"
  path        = "/"
  description = "Policy, which allows IG to access AWS"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "VisualEditor0",
        "Effect" : "Allow",
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Resource" : "arn:aws:secretsmanager:eu-west-2:*:secret:*mtls*"
      },
      {
        "Sid" : "VisualEditor1",
        "Effect" : "Allow",
        "Action" : "secretsmanager:GetRandomPassword",
        "Resource" : "*"
      }
    ]
  })
}
