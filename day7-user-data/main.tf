resource "aws_instance" "web121" {
    ami = "ami-02d7fd1c2af6eead0"
    instance_type = "t2.micro"
    key_name = "test"
    user_data = file ("test.sh")
    tags = {
      Name = "userdata123"
    }
  
}