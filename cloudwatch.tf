locals {

  pii_data_identifiers = [
    "arn:aws:dataprotection::aws:data-identifier/Name",
    "arn:aws:dataprotection::aws:data-identifier/Address",
    "arn:aws:dataprotection::aws:data-identifier/DateOfBirth",
    "arn:aws:dataprotection::aws:data-identifier/EmailAddress",
    "arn:aws:dataprotection::aws:data-identifier/VehicleIdentificationNumber",
    "arn:aws:dataprotection::aws:data-identifier/ZipCode-US"
  ]

}

resource "aws_cloudwatch_log_group" "employee_logs" {
  name              = "employee-logs"
  retention_in_days = 7
}

resource "aws_cloudwatch_log_group" "employee_audit_logs" {
  name              = "employee-audit-logs"
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
          cloudwatch_logs {
            log_group = aws_cloudwatch_log_group.employee_audit_logs.name
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

resource "aws_cloudwatch_metric_alarm" "log_events_with_pii_findings" {
  alarm_name          = "log-events-with-pii-findings"
  comparison_operator = "GreaterThanThreshold"
  period  = 60
  evaluation_periods = 1
  metric_name = "LogEventsWithFindings"
  namespace = "AWS/Logs"
  dimensions = {
    DataProtectionOperation = "Audit"
    LogGroupName = aws_cloudwatch_log_group.employee_logs.name
  }

  datapoints_to_alarm = 1
  statistic = "Sum"
  alarm_actions = [aws_sns_topic.slack_notification.arn]
}