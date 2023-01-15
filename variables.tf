variable "slack_channel_id" {
  description = "The id of the Slack channel"
  type        = string
  default     = "ABCDEFG1234"
}

variable "slack_workspace_id" {
  description = "The id of the Slack workspace"
  type        = string
  default     = "GHI456Y34"
}

variable "logging_level" {
  description = "Specifies the logging level for this configuration:ERROR,INFO or NONE. This property affects the log entries pushed to Amazon CloudWatch logs"
  type        = string
  default     = "ERROR"
}