module "employee_audit_logs_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "ds-employee-logs"
}

module "employee_audit_logs_bucket_notification" {
  source = "terraform-aws-modules/s3-bucket/aws//modules/notification"

  bucket      = module.employee_audit_logs_bucket.s3_bucket_id
  eventbridge = true

  sns_notifications = {
    sns1 = {
      topic_arn     = aws_sns_topic.s3_event_notification.arn
      events        = ["s3:ObjectCreated:Put", "s3:ObjectCreated:Post"]
    }
  }
}