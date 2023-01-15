resource "awscc_chatbot_slack_channel_configuration" "slack_channel_config" {
  configuration_name = var.configuration_name
  iam_role_arn       = var.iam_role_arn != "" ? var.iam_role_arn : aws_iam_role.chatbot_default_iam_role.arn
  slack_channel_id   = var.slack_channel_id
  slack_workspace_id = var.slack_workspace_id
  sns_topic_arns     = var.sns_topic_arns
  logging_level      = var.logging_level
  guardrail_policies = var.guardrail_policy_arns
}

resource "aws_iam_role" "chatbot_default_iam_role" {
  assume_role_policy = data.aws_iam_policy_document.chatbot_trust_policy.json
}

resource "aws_iam_role_policy" "chatbot_default_iam_role_policy" {
  policy = data.aws_iam_policy_document.chatbot_default_permission_policy.json
  role   = aws_iam_role.chatbot_default_iam_role.id
}
