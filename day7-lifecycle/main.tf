resource "aws_instance" "server" {
    ami = "ami-02d7fd1c2af6eead0"
    instance_type = "t2.micro"
    availability_zone = "us-east-1a"
    subnet_id = "subnet-037f7d773330e0c13"
    key_name = "test"
    tags = {
        Name = "server"
    }
  

lifecycle{
    ignore_changes = [tags,]
}
}