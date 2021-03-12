resource "aws_cognito_user_pool" "user_pool" {
  name             = "test"
  alias_attributes = []

  #This allow only admin to have the permission to add users in cognito##
  admin_create_user_config {
    allow_admin_create_user_only = true

    invite_message_template = {
      email_message = "Your username is {username} and password is {####}. "
      email_subject = "Your password"
      sms_message   = "Your username is {username} and password is {####}. "
    }
  }

  sms_authentication_message = "Your authentication code is {####}. "
  sms_verification_message   = "Your verification code is {####}. "

  ##Defines the passowrd policy for the users created##
  password_policy {
    minimum_length    = 8
    require_uppercase = true
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    temporary_password_validity_days = 7
  }

  ##Creates an attribute with below mentioned configurations##
  schema {
    name                     = "user"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
  }

  schema {
    name                     = "create_date"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false
  }

  schema {
    name                     = "text"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  schema {
    name                     = "id"
    attribute_data_type      = "String"
    developer_only_attribute = false
    mutable                  = true
    required                 = false

    string_attribute_constraints {
      min_length = 0
      max_length = 2048
    }
  }

  lifecycle {
    ignore_changes = ["schema"]
  }
}

resource "aws_cognito_user_pool_client" "user_pool_client" {
  name = "test"

  user_pool_id    = "${aws_cognito_user_pool.user_pool.id}"
  generate_secret = true

  ##Defines which attributes should have read and write permission##
  read_attributes  = ["custom:id", "custom:text", "custom:user", "custom:create_date"]
  write_attributes = ["custom:id", "custom:text", "custom:user", "custom:create_date"]

  explicit_auth_flows = [
    "ADMIN_NO_SRP_AUTH",
    "USER_PASSWORD_AUTH",
  ]
}