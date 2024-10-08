data "aws_iam_policy_document" "s3_kms_policy" {
  statement {
    sid       = "source-account-full-access"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.mgmt_account_id}:root"]
    }
  }
  statement {
    sid    = "target-account-allow-grant"
    effect = "Allow"
    # the following actions are required by Terraform to read/create/remove grants
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    # This allows any IAM role in the target account that has permission to create the grant to create the grant.
    # Can lock this down to a specific account in the target account so only that role is able to create grant for this key
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.app_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "cloudfront_kms_policy" {
  statement {
    sid       = "source-account-full-access"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.mgmt_account_id}:root"]
    }
  }
  statement {
    sid    = "target-account-allow-grant"
    effect = "Allow"
    # the following actions are required by Terraform to read/create/remove grants
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    # This allows any IAM role in the target account that has permission to create the grant to create the grant.
    # Can lock this down to a specific account in the target account so only that role is able to create grant for this key
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.app_account_id}:root"]
    }
  }
}

data "aws_iam_policy_document" "ebs_kms_policy" {
  statement {
    sid       = "source-account-full-access"
    effect    = "Allow"
    actions   = ["kms:*"]
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.mgmt_account_id}:root"]
    }
  }
  statement {
    sid    = "target-account-allow-grant"
    effect = "Allow"
    # the following actions are required by Terraform to read/create/remove grants
    actions = [
      "kms:CreateGrant",
      "kms:DescribeKey",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    # This allows any IAM role in the target account that has permission to create the grant to create the grant.
    # Can lock this down to a specific account in the target account so only that role is able to create grant for this key
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.app_account_id}:root"]
    }
  }
}