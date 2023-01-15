
resource "aws_cloudwatch_log_group" "employee_logs" {
  name              = "employee-logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_data_protection_policy" "log_data_protection_policy" {
  log_group_name  = aws_cloudwatch_log_group.employee_logs.name
  policy_document = data.aws_cloudwatch_log_data_protection_policy_document.log_data_protection_policy_document.json
}

data "aws_cloudwatch_log_data_protection_policy_document" "log_data_protection_policy_document" {
  name = "employee-logs-protection-policy"
  statement {
    sid = "Audit"

    data_identifiers = local.pii_data_identifiers

    operation {
      audit {
        findings_destination {
          s3 {
            bucket = module.employee_audit_logs_bucket.s3_bucket_id
          }
        }
      }
    }
  }
  statement {
    sid              = "Deidentify"
    data_identifiers = local.pii_data_identifiers
    operation {
      deidentify {
        mask_config {}
      }
    }
  }
}
