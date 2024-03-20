#create vpc
resource "aws_vpc" "devp" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "devp"
    }
  
}
#internet gateway
resource "aws_internet_gateway" "devp" {
    vpc_id = aws_vpc.devp.id
  
}
#subnet
resource "aws_subnet" "devp" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.devp.id
  
}

#create route
resource "aws_route_table" "devp" {
    vpc_id = aws_vpc.devp.id
    route {
        cidr_block ="0.0.0.0/16"
        gateway_id =aws_internet_gateway.devp.id
    }
  
}
#subnet association
resource "aws_route_table_association" "devp" {
    route_table_id = aws_route_table.devp.id
    subnet_id = aws_subnet.devp.id
  
}
