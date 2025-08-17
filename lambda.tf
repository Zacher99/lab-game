resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/lambda_code/lambda_function.zip"
  function_name = "LambdaGame-matheuszacher"
  role          = aws_iam_role.iam_role_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}
resource "aws_iam_role" "iam_role_lambda" {
  name = "lambda-iam-role-lab-game"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}
