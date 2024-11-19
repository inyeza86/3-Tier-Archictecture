# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "DEV-VPC"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "DEV-IGW"
  }
}

# Create a Public Subnet AZ1
resource "aws_subnet" "my_public_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "DEV-Public-Subnet-AZ1"
  }
}

# Create public subnet AZ2
resource "aws_subnet" "my_public_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "DEV-Public-Subnet-AZ2"
  }
}

# Create public route table
resource "aws_route_table" "my_public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "DEV-Public-Route-Table"
  }
}

# Associate public subnet1 with public route table
resource "aws_route_table_association" "my_public_subnet1_association" {
  subnet_id      = aws_subnet.my_public_subnet1.id
  route_table_id = aws_route_table.my_public_route_table.id
}

# Associate public subnet2 with public route table
resource "aws_route_table_association" "my_public_subnet2_association" {
  subnet_id      = aws_subnet.my_public_subnet2.id
  route_table_id = aws_route_table.my_public_route_table.id
}

# Create App private subnet AZ1
resource "aws_subnet" "my_private_subnet1" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "DEV-App-Private-Subnet-AZ1"
  }
}

# Create App private subnet2
resource "aws_subnet" "my_private_subnet2" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "DEV-App-Private-Subnet-AZ2"
  }
}

# Create DB private subnet AZ1
resource "aws_subnet" "my_private_subnet3" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "DEV-DB-Private-Subnet-AZ1"
  }
}

# Create DB private subnet AZ2
resource "aws_subnet" "my_private_subnet4" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.5.0/24"
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "DEV-DB-Private-Subnet-AZ2"
  }
}
# create elastic ip for the NAT Gateway
resource "aws_eip" "dev-nat-gateway" {
  domain = "vpc"
}

# create nat-gateway
resource "aws_nat_gateway" "dev-nat-gateway" {
  allocation_id = aws_eip.dev-nat-gateway.id
  subnet_id     = aws_subnet.my_public_subnet1.id

  tags = {
    Name = "DEV-NAT-GW"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.my_igw]
}

#create private route table
resource "aws_route_table" "my_private_route_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.dev-nat-gateway.id
  }

  tags = {
    Name = "DEV-Private-Route-Table"
  }
}

# Associate private subnet1 with private route table

resource "aws_route_table_association" "my_private_subnet1_association" {
  subnet_id      = aws_subnet.my_private_subnet1.id
  route_table_id = aws_route_table.my_private_route_table.id
}

# Associate private subnet2 with private route table
resource "aws_route_table_association" "my_private_subnet2_association" {
  subnet_id      = aws_subnet.my_private_subnet2.id
  route_table_id = aws_route_table.my_private_route_table.id
}
# Associate private subnet3 with private route table

resource "aws_route_table_association" "my_private_subnet3_association" {
  subnet_id      = aws_subnet.my_private_subnet3.id
  route_table_id = aws_route_table.my_private_route_table.id
}
# Associate private subnet4 with private route table
resource "aws_route_table_association" "my_private_subnet4_association" {
  subnet_id      = aws_subnet.my_private_subnet4.id
  route_table_id = aws_route_table.my_private_route_table.id
}


