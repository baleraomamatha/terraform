
#create vpc
resource "aws_vpc" "devp" {
    cidr_block = "10.0.0.0/16"
    tags = {
        name = "devp"
    }
  
}
#internet gateway
resource "aws_internet_gateway" "ig" {
    vpc_id = aws_vpc.devp.id
    tags = {
        Name = "devp"

    }
  
}
#subnet
resource "aws_subnet" "pub" {
    cidr_block = "10.0.0.0/24"
    vpc_id = aws_vpc.devp.id
  tags = {
    Name = "pub"
  }
}

#create route
resource "aws_route_table" "customroute" {
    vpc_id = aws_vpc.devp.id
    route {
        cidr_block ="0.0.0.0/16"
        gateway_id =aws_internet_gateway.ig.id
    }
  
}
#subnet association
resource "aws_route_table_association" "customroute" {
    route_table_id = aws_route_table.customroute.id
    subnet_id = aws_subnet.pub.id
  
}
#create private subnet
resource "aws_subnet" "pvt" {
    vpc_id = aws_vpc.devp.id
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "pvt"

    }
  
}
#create eip
resource "aws_eip" "elasticip" {
    tags = {
        Name = "eip"

    }
  
}
#create natgateway(select public subnet while doing)
resource "aws_nat_gateway" "natgateway" {
    subnet_id = aws_subnet.pub.id
    allocation_id = aws_eip.elasticip.id
    tags = {
        Name = "natgateway"

    }
  
}
#creating routetable and attach to Nat gateway &privatesub
resource "aws_route_table" "privateroute" {
    vpc_id = aws_vpc.devp.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.natgateway.id
    }
    tags = {
        Name = "privateroute"
    }
  
}
#attach privateroute to privatesubnet
resource "aws_route_table_association" "privateroute" {
    route_table_id = aws_route_table.privateroute.id
    subnet_id = aws_subnet.pvt.id
  
}
#create securitygroups
resource "aws_security_group" "ASG" {
    vpc_id = aws_vpc.devp.id
    ingress {
        description  = "TLS from vpc"
        from_port = 22
        to_port = 22
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks =["0.0.0.0/0"]
    }
  
}

