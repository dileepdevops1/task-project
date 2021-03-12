## Dynamodb table
resource "aws_dynamodb_table" "rxs_history_table" {
  name         = "test-${var.appname}"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "user"
  range_key    = "create_date"

  point_in_time_recovery {
    enabled = true
  }

  server_side_encryption {
    enabled = true
  }

  attribute {
    name = "user"
    type = "S"
  }

  attribute {
    name = "create_date"
    type = "N"
  }


  attribute {
    name = "text"
    type = "S"
  }

  attribute {
    name = "id"
    type = "N"
  }

  tags = {
    Environment = test
    appname     = var.appname
  }

  lifecycle {
    prevent_destroy = true
  }

}