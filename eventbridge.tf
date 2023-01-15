module "eventbridge" {
  source = "terraform-aws-modules/eventbridge/aws"

  create_bus = false

  rules = {
    employee-audit-logs = {
      description   = "Capture all employee audit logs"
      event_pattern = jsonencode({
        "source": ["aws.s3"],
        "detail-type": ["Object Created"],
        "detail": {
          "bucket": {
            "name": [module.employee_audit_logs_bucket.s3_bucket_id]
          }
        }
      })
      enabled       = true
    }
  }

  targets = {
    employee-audit-logs  = [
      {
        name            = "employee-audit-logs-sns"
        arn             = aws_sns_topic.s3_event_notification.arn
      }
    ]
  }
}