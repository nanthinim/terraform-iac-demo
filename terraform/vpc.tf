resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  #checkov:skip=CKV2_AWS_11:VPC logging is not needed

  tags = {
    Name = "Project VPC for IAC Demo - ${var.env}"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Public Subnet ${var.env} ${count.index + 1}"
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet_cidrs, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Subnet ${var.env} ${count.index + 1}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Project VPC for IAC Demo ${var.env} IG"
  }
}

resource "aws_route_table" "second_rt" {
  vpc_id = aws_vpc.main.id
  #checkov:skip=CKV2_AWS_44:Public route table needs to be open to public
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "2nd Route Table ${var.env}"
  }
}


resource "aws_route_table_association" "public_subnet_asso" {
  count          = length(var.public_subnet_cidrs)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.second_rt.id
}

#fix for CKV2_AWS_12
resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id

     ingress {
       protocol  = "-1"
       self      = true
       from_port = 0
       to_port   = 0
     }

  #   egress {
  #     from_port   = 0
  #     to_port     = 0
  #     protocol    = "-1"
  #     cidr_blocks = ["0.0.0.0/0"]
  #   }
}