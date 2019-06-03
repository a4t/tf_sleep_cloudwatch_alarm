resource "aws_cloudwatch_event_rule" "disable" {
  name                = "${var.resource_prefix}-CloudWatch-${var.disable_hour}h-disable-alarm-actions"
  description         = "${var.resource_prefix} CloudWatch ${var.disable_hour}h disable alarm actions"
  schedule_expression = "cron(0 ${var.disable_hour} * * ? *)"
}

resource "aws_cloudwatch_event_target" "disable_ssm_automation" {
  target_id = "${var.resource_prefix}-CloudWatch-${var.disable_hour}h-disable-alarm-actions"
  arn       = "${replace(aws_ssm_document.disable.arn, ":document/", ":automation-definition/")}:$DEFAULT"
  rule      = "${aws_cloudwatch_event_rule.disable.name}"
  role_arn  = "${aws_iam_role.cloudwatch_event.arn}"
}

resource "aws_cloudwatch_event_rule" "enable" {
  name                = "${var.resource_prefix}-CloudWatch-${var.enable_hour}h-enable-alarm-actions"
  description         = "${var.resource_prefix} CloudWatch ${var.enable_hour}h enable alarm actions"
  schedule_expression = "cron(0 ${var.enable_hour} * * ? *)"
}

resource "aws_cloudwatch_event_target" "enable_ssm_automation" {
  target_id = "${var.resource_prefix}-CloudWatch-${var.enable_hour}h-enable-alarm-actions"
  arn       = "${replace(aws_ssm_document.enable.arn, ":document/", ":automation-definition/")}:$DEFAULT"
  rule      = "${aws_cloudwatch_event_rule.enable.name}"
  role_arn  = "${aws_iam_role.cloudwatch_event.arn}"
}
