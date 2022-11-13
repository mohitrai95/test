#------------------------------------------------------------------------------
# AWS SQS
#------------------------------------------------------------------------------

resource "aws_sqs_queue" "sqs1" {
  name = "sqs1"
}

resource "aws_sqs_queue_policy" "my_sqs_policy" {
  queue_url = aws_sqs_queue.sqs1.id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.sqs1.arn}"
    }
  ]
}
POLICY
}
