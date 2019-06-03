resource "aws_ssm_document" "disable" {
  name            = "${var.resource_prefix}-CloudWatch-${var.disable_hour}h-disable-alarm-actions"
  document_type   = "Automation"
  document_format = "YAML"

  content = <<DOC
{
  "schemaVersion": "0.3",
  "description": "${var.resource_prefix}-CloudWatch-${var.disable_hour}h-disable-alarm-actions",
  "mainSteps": [
    {
      "name": "aws_cloudwatch_disable_alarm_actions",
      "action": "aws:executeAwsApi",
      "inputs": {
        "Service": "cloudwatch",
        "Api": "DisableAlarmActions",
        "AlarmNames": ${jsonencode(var.alarm_names)}
      }
    }
  ]
}
DOC
}

resource "aws_ssm_document" "enable" {
  name = "${var.resource_prefix}-CloudWatch-${var.enable_hour}h-enable-alarm-actions"
  document_type = "Automation"
  document_format = "YAML"

  content = <<DOC
{
  "schemaVersion": "0.3",
  "description": "${var.resource_prefix}-${var.enable_hour}h-enable-alarm-actions",
  "mainSteps": [
    {
      "name": "aws_cloudwatch_enable_alarm_actions",
      "action": "aws:executeAwsApi",
      "inputs": {
        "Service": "cloudwatch",
        "Api": "EnableAlarmActions",
        "AlarmNames": ${jsonencode(var.alarm_names)}
      }
    }
  ]
}
DOC
}
