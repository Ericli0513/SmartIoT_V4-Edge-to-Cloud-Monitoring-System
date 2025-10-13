# ========================================================
# iam.tf
# 完整 IAM Role + Lambda Policy Attachments
# ========================================================

# =========================================
# 1️⃣ Assume Role Policy Document
# =========================================
data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
    actions = ["sts:AssumeRole"]
  }
}

# =========================================
# 2️⃣ Lambda Execution Role
# =========================================
resource "aws_iam_role" "lambda_exec" {
  name               = "LambdaExecutionRole"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

# =========================================
# 3️⃣ Inline IAM Policies
# =========================================

# Device Timestream Policy
resource "aws_iam_policy" "lambda_device_timestream" {
  name        = "LambdaDeviceTimestreamPolicy"
  description = "Policy for Lambda Device to write to Timestream"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "timestream:WriteRecords",
        "timestream:DescribeEndpoints"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

# TSWriter Timestream Policy
resource "aws_iam_policy" "lambda_tswriter_timestream" {
  name        = "LambdaTSWriterTimestreamPolicy"
  description = "Policy for Lambda TSWriter to write to Timestream"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "timestream:WriteRecords",
        "timestream:DescribeEndpoints"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

# Device DynamoDB Policy
resource "aws_iam_policy" "lambda_device_dynamodb" {
  name        = "LambdaDeviceDynamoDBPolicy"
  description = "Policy for Lambda Device to access DynamoDB"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:UpdateItem",
        "dynamodb:Scan",
        "dynamodb:Query"
      ],
      "Resource": "*"
    }
  ]
}
POLICY
}

# ............

# =========================================
# 4️⃣ Lambda Role Policy Attachments
# =========================================
resource "aws_iam_role_policy_attachment" "lambda_device_timestream_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_device_timestream.arn
}

resource "aws_iam_role_policy_attachment" "lambda_tswriter_timestream_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_tswriter_timestream.arn
}

resource "aws_iam_role_policy_attachment" "lambda_device_dynamodb_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_device_dynamodb.arn
}

resource "aws_iam_role_policy_attachment" "lambda_retry_dynamodb_attach" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = aws_iam_policy.lambda_retry_dynamodb.arn
}
