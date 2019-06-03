# tf_sleep_cloudwatch_alarm

This terraform module can turn off CloudWatch alarms temporarily.

For example, it is effective when you want to turn off the alarm at night.

## Module Input Variables

- `resource_prefix` - (Required) Resource name prefix strings (String)
- `alarm_names` - (Required) Sleep alarm lists (List)
- `disable_hour` - (Required) Sleep start hour (Integer)
- `enable_hour` - (Required) Sleep stop hour (Integer)

## Usage

```hcl
module sleep_cloudwatch_alarm {
  source          = "github.com/a4t/tf_sleep_cloudwatch_alarm"
  resource_prefix = "foobar"
  alarm_names     = ["alarm_name1", "alarm_name2"]
  disable_hour    = 20
  enable_hour     = 8
}
```

## Architecture

CloudWatch Event (Cron) -> SSM Automation -> (Enable|Disable)AlarmActions
