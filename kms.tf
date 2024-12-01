data "aws_caller_identity" "current" {}

resource "aws_kms_key" "ec2_kms_key" {
  depends_on              = [aws_iam_role.ec2_role, aws_iam_instance_profile.ec2_instance_profile]
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
  tags = {
    "name": "for ec2"
  }
  policy = jsonencode({
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:user/awscli"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:RotateKeyOnDemand"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "*",
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  })
}

resource "aws_kms_key" "rds_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
  tags = {
    "name": "for rds"
  }
  policy = jsonencode({
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:RotateKeyOnDemand"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"   #arn:aws:iam::209479307750:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "arn:aws:rds*" #arn:aws:rds:us-east-1:209479307750:db:csye6225
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"  #arn:aws:iam::209479307750:role/aws-service-role/rds.amazonaws.com/AWSServiceRoleForRDS
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "arn:aws:rds*", #arn:aws:rds:us-east-1:209479307750:db:csye6225
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  })
}

resource "aws_kms_key" "s3_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
  tags = {
    "name": "for s3"
  }
  policy = jsonencode({
    "Id" : "key-consolepolicy-3",
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:user/awscli"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:RotateKeyOnDemand"
        ],
        "Resource" : "*"
      },
      {
        "Sid" : "Allow use of the key",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "arn:aws:s3:::*" #arn:aws:s3:::csye6225-bucket-39a79331-8d1e-0ea9-c318-e70398572c9d
      },
      {
        "Sid" : "Allow attachment of persistent resources",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "*"
        },
        "Action" : [
          "kms:CreateGrant",
          "kms:ListGrants",
          "kms:RevokeGrant"
        ],
        "Resource" : "arn:aws:s3:::*", #arn:aws:s3:::csye6225-bucket-39a79331-8d1e-0ea9-c318-e70398572c9d
        "Condition" : {
          "Bool" : {
            "kms:GrantIsForAWSResource" : "true"
          }
        }
      }
    ]
  })

}

resource "aws_kms_key" "rds_password_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
  tags = {
    "name": "for rds password"
  }
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "KMSSecretsManagerPolicy",
    "Statement" : [
      {
        "Sid" : "AllowSecretsManagerToUseKeyForSpecificSecret",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "secretsmanager.amazonaws.com"
        },
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "kms:CallerAccount" : "209479307750",
            "kms:ViaService" : "secretsmanager.us-east-1.amazonaws.com",

          }
        }
      },
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:user/awscli"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:RotateKeyOnDemand"
        ],
        "Resource" : "*"
      },
      # {
      #     "Sid": "AllowKeyAdminAccess",
      #     "Effect": "Allow",
      #     "Principal": {
      #         "AWS": "arn:aws:iam::209479307750:user/awscli"
      #     },
      #     "Action": "kms:*",
      #     "Resource": "*"
      # }
    ]
    }
  )
}

resource "aws_kms_key" "sendGrid_kms_key" {
  description             = "A symmetric encryption KMS key"
  enable_key_rotation     = true
  rotation_period_in_days = 90
  tags = {
    "name": "for sendgrid"
  }
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "KMSSecretsManagerPolicy",
    "Statement" : [
      {
        "Sid" : "AllowSecretsManagerToUseKeyForSpecificSecret",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "secretsmanager.amazonaws.com"
        },
        "Action" : [
          "kms:Decrypt",
          "kms:Encrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        "Resource" : "*",
        "Condition" : {
          "StringEquals" : {
            "kms:CallerAccount" : "209479307750",
            "kms:ViaService" : "secretsmanager.us-east-1.amazonaws.com",

          }
        }
      },
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:root"
        },
        "Action" : "kms:*",
        "Resource" : "*"
      },
      {
        "Sid" : "Allow access for Key Administrators",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : "arn:aws:iam::209479307750:user/awscli"
        },
        "Action" : [
          "kms:Create*",
          "kms:Describe*",
          "kms:Enable*",
          "kms:List*",
          "kms:Put*",
          "kms:Update*",
          "kms:Revoke*",
          "kms:Disable*",
          "kms:Get*",
          "kms:Delete*",
          "kms:TagResource",
          "kms:UntagResource",
          "kms:ScheduleKeyDeletion",
          "kms:CancelKeyDeletion",
          "kms:RotateKeyOnDemand"
        ],
        "Resource" : "*"
      },
      # {
      #     "Sid": "AllowKeyAdminAccess",
      #     "Effect": "Allow",
      #     "Principal": {
      #         "AWS": "arn:aws:iam::209479307750:user/awscli"
      #     },
      #     "Action": "kms:*",
      #     "Resource": "*"
      # }
    ]
    })
}

# resource "aws_kms_key_policy" "ec2_kms_policy" {
#   key_id = aws_kms_key.ec2_kms_key.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Id      = "key-default-1"
#     Statement = [
#       {
#         Sid    = "Enable IAM User Permissions"
#         Effect = "Allow"
#         Principal = {
#           AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#         },
#         Action   = "kms:*"
#         Resource = "arn:aws:ec2:us-east-1:*"
#       }
#     ]
#   })
# }