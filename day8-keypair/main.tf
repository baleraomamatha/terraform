resource "aws_key_pair" "linux" {
    key_name = "server"
    public_key = file("~/.ssh/id_ed25519.pub")

  
}
resource "aws_instance" "server23" {
    ami = "ami-02d7fd1c2af6eead0"
    instance_type = "t2.micro"
    key_name = aws_key_pair.linux.key_name

  
}