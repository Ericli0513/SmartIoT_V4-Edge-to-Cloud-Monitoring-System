# Lambda networking
variable "lambda_subnets" {
  description = "List of subnet IDs for the Lambda function"
  type        = list(string)
}

variable "lambda_sg" {
  description = "Security group ID for the Lambda function"
  type        = string
}

# DynamoDB table name
variable "dynamo_table_name" {
  description = "Existing DynamoDB table name for device data"
  type        = string
}


variable "influx_url" {
  type = string
}

variable "influx_token" {
  type = string
}

variable "influx_db" {
  type = string
}

variable "influx_table" {
  type = string
}

variable "influx_org" {
  type = string
}

variable "influx_bucket" {
  type = string
}

variable "redis_host" {
  description = "Redis cluster endpoint"
  type        = string
}

variable "redis_port" {
  description = "Redis cluster port"
  type        = number
  default     = 6379
}


