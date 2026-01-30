mock_provider "aws" {
  override_data {
    target = data.aws_iam_policy_document.assume_role
    values = {
      json = "{\"Version\": \"2012-10-17\", \"Statement\": []}"
    }
  }

  override_data {
    target = data.aws_iam_policy_document.lambda_logging
    values = {
      json = "{\"Version\": \"2012-10-17\", \"Statement\": []}"
    }
  }
}

run "verify_deployment" {
  command = plan

  variables {
    function_name   = "test-function-1"
    lambda_zip_path = "./tests/fixtures/payload.zip"
  }

  assert {
    condition     = aws_lambda_function.this.function_name == "test-function-1"
    error_message = "Function name resource did not match expected value"
  }

  assert {
    condition     = aws_lambda_function.this.handler == "index.handler"
    error_message = "Default handler did not match expected value"
  }

  assert {
    condition     = aws_lambda_function.this.runtime == "python3.11"
    error_message = "Default runtime did not match expected value"
  }

  assert {
    condition     = aws_cloudwatch_log_group.this.name == "/aws/lambda/test-function-1"
    error_message = "Log group name resource incorrectly formed"
  }

  assert {
    condition     = output.function_name == "test-function-1"
    error_message = "Output 'function_name' mismatch"
  }

  assert {
    condition     = output.role_name == "test-function-1-role"
    error_message = "Output 'role_name' mismatch. Should include '-role' suffix."
  }

  assert {
    condition     = output.log_group_name == "/aws/lambda/test-function-1"
    error_message = "Output 'log_group_name' mismatch"
  }
}

run "verify_custom_settings" {
  command = plan

  variables {
    function_name   = "test-function-2"
    handler         = "custom.handler"
    runtime         = "nodejs18.x"
    timeout         = 60
    lambda_zip_path = "./tests/fixtures/payload.zip"
  }

  assert {
    condition     = aws_lambda_function.this.runtime == "nodejs18.x"
    error_message = "Runtime did not match expected value"
  }

  assert {
    condition     = aws_lambda_function.this.timeout == 60
    error_message = "Timeout did not match expected value"
  }
}

run "verify_validation_failure" {
  command = plan

  variables {
    function_name   = "test-fail"
    runtime         = "ruby3.2"
    lambda_zip_path = "./tests/fixtures/payload.zip"
  }

  expect_failures = [
    var.runtime
  ]
}
