module "employee_audit_logs_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = local.audit_logs_bucket_name
}

module "employee_audit_logs_bucket_notification" {
  source = "terraform-aws-modules/s3-bucket/aws//modules/notification"

  bucket      = module.employee_audit_logs_bucket.s3_bucket_id
  eventbridge = true
}