output "function_arn" {
  description = "The ARN of the Lambda Function"
  value       = aws_lambda_function.this.arn
}

output "function_name" {
  description = "The name of the Lambda Function"
  value       = aws_lambda_function.this.function_name
}

output "invoke_arn" {
  description = "The Invoke ARN of the Lambda Function."
  value       = aws_lambda_function.this.invoke_arn
}

output "role_arn" {
  description = "The ARN of the IAM role created for the Lambda Function"
  value       = aws_iam_role.iam_for_lambda.arn
}
output "role_name" {
  description = "The name of the IAM role. Useful for policy attachments."
  value       = aws_iam_role.iam_for_lambda.name
}

output "log_group_arn" {
  description = "The ARN of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.arn
}
output "log_group_name" {
  description = "The name of the CloudWatch Log Group"
  value       = aws_cloudwatch_log_group.this.name
}
