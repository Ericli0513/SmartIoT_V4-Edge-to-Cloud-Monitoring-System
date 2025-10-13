# =========================================
# 1️⃣ Lambda: Device Data Processor
# =========================================
resource "aws_lambda_function" "device_data_processor" {
  function_name    = "device_data_processor"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 30

  # 指向壓縮檔（加上 path.module）
  filename         = "${path.module}/lambda_shared.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_shared.zip")

  environment {
    variables = {
      DYNAMO_TABLE   = var.dynamo_table_name
      INFLUX_URL     = var.influx_url
      INFLUX_TOKEN   = var.influx_token
      INFLUX_ORG     = var.influx_org
      INFLUX_BUCKET  = var.influx_bucket
      REDIS_HOST     = var.redis_host
      REDIS_PORT     = var.redis_port
    }
  }
}

# =========================================
# 2️⃣ Lambda: TS Writer
# =========================================
resource "aws_lambda_function" "ts_writer" {
  function_name    = "ts_writer"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 30

  filename         = "${path.module}/lambda_shared.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_shared.zip")

  environment {
    variables = {
      DYNAMO_TABLE   = var.dynamo_table_name
      INFLUX_URL     = var.influx_url
      INFLUX_TOKEN   = var.influx_token
      INFLUX_ORG     = var.influx_org
      INFLUX_BUCKET  = var.influx_bucket
      REDIS_HOST     = var.redis_host
      REDIS_PORT     = var.redis_port
    }
  }
}

# =========================================
# 3️⃣ Lambda: Retry Processor
# =========================================
resource "aws_lambda_function" "retry_processor" {
  function_name    = "retry_processor"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "lambda_function.lambda_handler"
  runtime          = "python3.12"
  timeout          = 30

  filename         = "${path.module}/lambda_shared.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_shared.zip")

  environment {
    variables = {
      DYNAMO_TABLE   = var.dynamo_table_name
      INFLUX_URL     = var.influx_url
      INFLUX_TOKEN   = var.influx_token
      INFLUX_ORG     = var.influx_org
      INFLUX_BUCKET  = var.influx_bucket
      REDIS_HOST     = var.redis_host
      REDIS_PORT     = var.redis_port
    }
  }
}
