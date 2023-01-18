resource "aws_sns_topic" "s3_event_notification" {
  name = "employee-audit-logs-notification"
  display_name = "Employee Audit Log Notification"
}

module "slack_channel_configuration" {
  source             = "./modules/chatbot-slack"
  configuration_name = "employee-audit-logs"
  slack_workspace_id = var.slack_workspace_id
  slack_channel_id   = var.slack_channel_id
  sns_topic_arns     = [aws_sns_topic.s3_event_notification.arn]
  logging_level      = var.logging_level
}