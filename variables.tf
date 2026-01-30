variable "function_name" {
  description = "Unique name for your Lambda Function."
  type        = string
}

variable "lambda_zip_path" {
  description = "Path to the local zip file containing the lambda code."
  type        = string
}

variable "handler" {
  description = "Function entrypoint in your code."
  type        = string
  default     = "index.handler"
}

variable "runtime" {
  description = "Identifier of the function's runtime."
  type        = string
  default     = "python3.11"
  validation {
    condition     = can(regex("^(python|nodejs)", var.runtime))
    error_message = "Runtime must be a Python or Node.js runtime."
  }
}

variable "timeout" {
  description = "Amount of time your Lambda Function has to run in seconds."
  type        = number
  default     = 30
}

variable "environment_variables" {
  description = "Map of environment variables."
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A map of tags to assign to the resources."
  type        = map(string)
  default     = {}
}
