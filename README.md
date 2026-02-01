# Terraform AWS Lambda Function Module

![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.9.0-purple)
![AWS Provider](https://img.shields.io/badge/provider-aws-orange)
![Tests](https://github.com/almsid/terraform-aws-lambda-function/actions/workflows/test.yml/badge.svg)

A reusable Terraform module to deploy an AWS Lambda function with its associated IAM role and CloudWatch Log Group. This module adheres to AWS best practices, ensuring your function is secure and observable by default.

## Features

- **Automatic IAM Role:** Creates a dedicated IAM execution role for the function.
- **Logging Enabled:** Automatically creates a CloudWatch Log Group with retention settings.
- **Flexible Source:** Supports deploying code from a local ZIP file.
- **Tagging Support:** Propagates tags to all created resources.

## Usage

```hcl
module "my_lambda" {
  source = "github.com/almsid/terraform-aws-lambda-function?ref=v1.0.0"

  function_name   = "my-cool-function"
  lambda_zip_path = "./build/function.zip"
  handler         = "index.handler"
  runtime         = "python3.11"
  timeout         = 60

  environment_variables = {
    ENV_TYPE = "production"
  }

  tags = {
    Environment = "Production"
    Project     = "MyProject"
  }
}
```

## Requirements

| Name      | Version  |
| --------- | -------- |
| terraform | >= 1.9.0 |
| aws       | >= 5.30  |

## Inputs

| Name                                                                                             | Description                                                          | Type          | Default           | Required |
| ------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------- | ------------- | ----------------- | :------: |
| <a name="input_function_name"></a> [function_name](#input_function_name)                         | Unique name for your Lambda Function.                                | `string`      | n/a               |   yes    |
| <a name="input_lambda_zip_path"></a> [lambda_zip_path](#input_lambda_zip_path)                   | Path to the local zip file containing the lambda code.               | `string`      | n/a               |   yes    |
| <a name="input_handler"></a> [handler](#input_handler)                                           | Function entrypoint in your code.                                    | `string`      | `"index.handler"` |    no    |
| <a name="input_runtime"></a> [runtime](#input_runtime)                                           | Identifier of the function's runtime (e.g., python3.11, nodejs18.x). | `string`      | `"python3.11"`    |    no    |
| <a name="input_timeout"></a> [timeout](#input_timeout)                                           | Amount of time your Lambda Function has to run in seconds.           | `number`      | `30`              |    no    |
| <a name="input_environment_variables"></a> [environment_variables](#input_environment_variables) | Map of environment variables accessible from the function code.      | `map(string)` | `{}`              |    no    |
| <a name="input_tags"></a> [tags](#input_tags)                                                    | A map of tags to assign to the resources.                            | `map(string)` | `{}`              |    no    |

## Outputs

| Name                                                                          | Description                                        |
| ----------------------------------------------------------------------------- | -------------------------------------------------- |
| <a name="output_function_arn"></a> [function_arn](#output_function_arn)       | The ARN of the Lambda Function.                    |
| <a name="output_function_name"></a> [function_name](#output_function_name)    | The name of the Lambda Function.                   |
| <a name="output_invoke_arn"></a> [invoke_arn](#output_invoke_arn)             | The Invoke ARN (used for API Gateway integration). |
| <a name="output_role_arn"></a> [role_arn](#output_role_arn)                   | The ARN of the IAM role created for the Lambda.    |
| <a name="output_role_name"></a> [role_name](#output_role_name)                | The name of the IAM role.                          |
| <a name="output_log_group_name"></a> [log_group_name](#output_log_group_name) | The name of the CloudWatch Log Group.              |
| <a name="output_log_group_arn"></a> [log_group_arn](#output_log_group_arn)    | The ARN of the CloudWatch Log Group.               |

## Development

### Prerequisites

- Terraform >= 1.9.0
- A zip utility

### Running Tests

To run the tests locally, you can use the provided Makefile or run the commands manually.

**Using Make:**

```bash
make test

```

**Manual:**

```bash
cd tests/fixtures
zip -r payload.zip index.py
cd ../..
terraform test

```

## License

MIT License. See [LICENSE](https://github.com/almsid/terraform-aws-lambda-function/blob/master/LICENSE) for full text.
