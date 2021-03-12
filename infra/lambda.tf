resource "aws_lambda_function" "http_basic_authenticator" {
  function_name                  = "${var.appname}-HttpBasicAuthenticator"
  handler                        = "index.handler"
  runtime                        = "python3.7"
  filename                       = "./files/basic_auth_function.zip"
  reserved_concurrent_executions = 10
  role                           = arn:aws:iam::${var.accountid}:role/test

  environment {
    variables = {
    Environment = test
    appname     = var.appname
    
    }
  }

}