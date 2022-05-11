#tfsec:ignore:aws-iam-no-policy-wildcards
resource "aws_iam_policy" "idm_policy" {
  name        = "${local.cluster_name}_idm"
  path        = "/"
  description = "Policy, which allows IDM to issue and revoke PKI certs"

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "pki",
        "Effect" : "Allow",
        "Action" : [
          "acm-pca:IssueCertificate",
          "acm-pca:RevokeCertificate"
        ],
        "Resource" : "${var.ca_arn}"
      },
      {
        "Sid" : "s3",
        "Effect" : "Allow",
        "Action" : [
          "s3:GetObject",
          "s3:List*"
        ],
        "Resource" : [
          "arn:aws:s3:::origo-onboarding-*",
          "arn:aws:s3:::origo-onboarding-*/*"
        ]
      }
    ]
  })
}
