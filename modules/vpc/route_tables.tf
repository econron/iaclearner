resource "aws_route_table" "public_route_tables" {
  for_each = aws_subnet.public_subnets
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.service_name}-${var.env}-${each.value.availability_zone}-public-route-table"
    AvailabilityZone = each.value.availability_zone
    Scope = "public"
  }
}

resource "aws_route" "public_default_route" {
  for_each = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_route_tables[each.key].id

  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
}

# public subnet用のルートテーブル関連づけ
resource "aws_route_table_association" "public_route_table_associations" {
  for_each = aws_subnet.public_subnets
  route_table_id = aws_route_table.public_route_tables[each.key].id
  subnet_id = each.value.id
}

resource "aws_route_table" "private_route_tables" {
  for_each = aws_subnet.private_subnets
  vpc_id = aws_vpc.vpc_id
  tags = {
    Name = "${var.service_name}-${var.env}-${each.value.availability_zone}-private-route-table"
    AvailabilityZone = each.value.availability_zone
    Scope = "private"
  }
}

# private subnet用のルートテーブル関連付け
resource "aws_route_table_association" "private_route_table_associations" {
  for_each = aws_subnet.private_subnets
  route_table_id = aws_route.private_route_tables[each.key].id
  subnet_id = each.value.id
}

# private subnet用のデフォルトルート
resource "aws_route" "private_default_route" {
  for_each = aws_subnet.private_subnets
  route_table_id = aws_route_table.private_route_tables[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat_gateways[each.value.availability_zone].id
}