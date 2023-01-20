variable "configuration_name" {
  description = "The name of the slack configuration"
  type        = string
}
variable "iam_role_arn" {
  description = "The ARN of the IAM role that defines the permissions for AWS Chatbot"
  type        = string
  default     = ""
}
variable "slack_channel_id" {
  description = "The ID of the Slack channel"
  type        = string
}
variable "slack_workspace_id" {
  description = "The ID of the Slack workspace"
  type        = string
}

variable "sns_topic_arns" {
  description = "ARNs of SNS topics which delivers notifications to AWS Chatbot, for example CloudWatch alarm notifications"
  type        = list(string)
  default     = []
}

variable "logging_level" {
  description = "Specifies the logging level for this configuration:ERROR,INFO or NONE. This property affects the log entries pushed to Amazon CloudWatch logs"
  type        = string
  default     = "NONE"
}

variable "guardrail_policy_arns" {
  description = "The list of IAM policy ARNs that are applied as channel guardrails"
  type        = list(string)
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}