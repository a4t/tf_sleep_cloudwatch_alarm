resource "aws_iam_role" "cloudwatch_event" {
  name = "${var.resource_prefix}-Sleep-CloudWatch-Alarm"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "events.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "ssm" {
  name = "ssm"
  role = "${aws_iam_role.cloudwatch_event.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ssm",
            "Effect": "Allow",
            "Action": [
                "ssm:StartAutomationExecution"
            ],
            "Resource": [
                "${replace(aws_ssm_document.enable.arn, ":document/", ":automation-definition/")}:$DEFAULT",
                "${replace(aws_ssm_document.disable.arn, ":document/", ":automation-definition/")}:$DEFAULT"
            ]
        }
    ]
}
EOF
}

resource "aws_iam_role_policy" "cloudwatch" {
  name = "cloudwatch"
  role = "${aws_iam_role.cloudwatch_event.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ssm",
            "Effect": "Allow",
            "Action": [
                "cloudwatch:DisableAlarmActions",
                "cloudwatch:EnableAlarmActions"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
