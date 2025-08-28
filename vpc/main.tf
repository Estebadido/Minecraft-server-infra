resource "aws_vpc" "vpc_minecraft" {
  cidr_block = "10.0.0.0/16"
  tags = merge(
    var.tags,
    {
      Name        = "vpc-minecraft"
    }
  )
}

resource "aws_subnet" "subnet_private" {
  vpc_id            = aws_vpc.vpc_minecraft.id
  cidr_block        = "10.0.1.0/24"
  tags = merge(
    var.tags,
    {
      Name = "subnet-private-minecraft"
    }
  )
  
}

resource "aws_subnet" "subnet_public" {
  vpc_id            = aws_vpc.vpc_minecraft.id
  cidr_block        = "10.0.2.0/24"
  tags = merge(
    var.tags,
    {
      Name = "subnet-private-minecraft"
    }
  )
  
}

resource "aws_internet_gateway" "igw_mineacraft" {
  vpc_id = aws_vpc.vpc_minecraft.id
  tags = merge(
    var.tags,
    {
      Name = "igw-minecraft"
    }
  )
  
}

resource "aws_eip" "epi_nat_minecraft" {
  domain   = "vpc"
  tags = merge(
    var.tags,
    {
      Name = "eip-nat-minecraft"
    }
  )
}

resource "aws_nat_gateway" "nat_gw_minecraft" {

  subnet_id     = aws_subnet.subnet_public
  allocation_id = aws_eip.epi_nat_minecraft.id
tags = merge(
    var.tags,
    {
      Name = "nat-gw-minecraft"
    }
  )
  depends_on = [aws_internet_gateway.igw_mineacraft]
}

resource "aws_route_table" "route_table_public" {
  vpc_id = aws_vpc.vpc_minecraft.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_mineacraft.id
  }
tags = merge(
    var.tags,
    {
      Name = "route-table-public-minearcraft"
    }
  )
}
resource "aws_route_table" "route_table_private" {
  vpc_id = aws_vpc.vpc_minecraft.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw_minecraft.id
  }
tags = merge(
    var.tags,
    {
      Name = "route-table-private-minecraft"
    }
  )
}
resource "aws_route_table_association" "Association_Route_Table_Public" {
  subnet_id      = aws_subnet.subnet_public.id
  route_table_id = aws_route_table.route_table_public.id
}
resource "aws_route_table_association" "Association_Route_Table_Private" {
  subnet_id      = aws_subnet.subnet_private.id
  route_table_id = aws_route_table.route_table_private.id
}