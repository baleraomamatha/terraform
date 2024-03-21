resource "aws_s3_bucket" "developer" {
    bucket = "mamathahimansh"
  
}
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" { 
    name = "terraform-state-lock-dynamo"
    hash_key = "LOCKID"
    read_capacity = 20
    write_capacity = 20

  attribute {
        name = "LOCKID"
        type = "S"
      
    }
  
}
