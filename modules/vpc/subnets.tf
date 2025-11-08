resource "aws_subnet" "public_subnets" {
  for_each = toset(var.subnet_cidrs.public)
  cidr_block = each.key
  vpc_id = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[
    index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones
  ]
}

resource "aws_subnet" "private_subnets" {
  for_each = toset(var.subnet_cidrs.private)
  cidr_block = each.key
  vpc_id = aws_vpc.vpc.id

  availability_zone = data.aws_availability_zones.availability_zones.names[
    index(var.subnet_cidrs.public, each.key) % local.number_of_availability_zones
  ]
}