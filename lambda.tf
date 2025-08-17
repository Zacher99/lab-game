resource "aws_lambda_function" "lambda" {
  filename      = "lambda_funcion.zip"
  function_name = "LambdaGame-matheuszacher"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
}
