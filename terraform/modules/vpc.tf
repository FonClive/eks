resource "aws_vpc" "eks_vpc" {
  for_each = var.vpc_parameters
  cidr_block = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support = each.value.enable_dns_support
  tags = merge(each.value.tags, {
    Name: each.key
  })
}

resource "aws_subnet" "eks_subnet" {
  for_each = var.subnet_parameters
  vpc_id = aws_vpc.eks_vpc[each.value.vpc_name].id 
  cidr_block = each.value.cidr_block 
  tags = merge(each.value.tags, {
    Name: each.key
  })
}

resource "aws_internet_gateway" "eks_internet_gateway" {
  vpc_id = aws_vpc.eks_vpc.id 
  tags = {
    name = var.environment
  }
}

resource "aws_internet_gateway_attachment" "eks_internet_gateway_attachment" {
  internet_gateway_id = aws_internet_gateway.eks_internet_gateway.id 
  vpc_id = aws_vpc.eks_vpc.id
}

resource "aws_route_table" "eks_routes" {
  for_each = var.rt_parameters
  vpc_id = aws_vpc.this[each.value.eks_vpc].id
}