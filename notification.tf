resource "aws_sns_topic" "s3_event_notification" {
  name = "employee-audit-log-notification"
  display_name = "Employee Audit Log Notification"
}