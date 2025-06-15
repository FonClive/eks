resource "aws_vpc" "eks_vpc" {
  for_each             = var.vpc_parameters
  cidr_block           = each.value.cidr_block
  enable_dns_hostnames = each.value.enable_dns_hostnames
  enable_dns_support   = each.value.enable_dns_support
  tags = merge(each.value.tags, {
    Name : each.key
  })
}

resource "aws_subnet" "eks_subnet" {
  for_each   = var.subnet_parameters
  vpc_id     = aws_vpc.eks_vpc[each.value.vpc_name].id
  cidr_block = each.value.cidr_block
  tags = merge(each.value.tags, {
    Name : each.key
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
  vpc_id              = aws_vpc.eks_vpc.id
}

resource "aws_route_table" "eks_routes" {
  for_each = var.rt_parameters
  vpc_id   = aws_vpc.this[each.value.eks_vpc].id
  tags = merge(each.value.tags, {
    Name : each.key
  })

  dynamic "route" {
    for_each = each.value.routes
    content {
      cidr_block = route.value.cidr_block
      gateway_id = route.value.use_igw ? aws_internet_gateway.this[route.value.gateway_id].id : route.value.gateway_id

    }
  }
}

resource "aws_route_table_association" "eks_rta" {
  for_each       = var.rt_association_parameters
  subnet_id      = aws_subnet.this[each.value.subnet_name].vpc_id
  route_table_id = aws_route_table.this[each.value.rt_name].id
}

