# Create a VPC
resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "hangaramit_vpc_${var.env}"
  }
}

# Create a Public Subnet
# 퍼블릭 서브넷은 dev 일 때만 만들어져야 한다.
resource "aws_subnet" "public_subnet_1" {
  # count 반복문의 특징: 0번 반복은 실행이 되지 않음
  count             = var.env == "dev" ? 1 : 0
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.100.0/24"
  availability_zone = local.az_a
  tags = {
    Name = "hangaramit_public_subnet_1${var.env}"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id            = aws_vpc.default.id
  cidr_block        = "10.0.102.0/24"
  availability_zone = local.az_a
  tags = {
    Name = "hangaramit_private_subnet_1${var.env}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.default.id
  tags = {
    Name = "hangaramit_igw_${var.env}"
  }
}

resource "aws_nat_gateway" "public_nat" {
  count             = var.env == "dev" ? 1 : 0
  connectivity_type = "public"
  subnet_id         = aws_subnet.public_subnet_1[0].id
}
