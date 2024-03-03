resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }
}

resource "aws_subnet" "public" {
  count = var.availability_zones

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.cidr_bits, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    "Name"                                                           = "${var.customer_name}-${var.project_name}-public-${data.aws_availability_zones.available.names[count.index]}"
    "kubernetes.io/role/elb"                                         = "1"
    "kubernetes.io/cluster/${var.customer_name}-${var.project_name}" = "owned"
  }
}

resource "aws_subnet" "private" {
  count = var.availability_zones

  vpc_id            = aws_vpc.main.id
  cidr_block        = cidrsubnet(var.cidr_block, var.cidr_bits, count.index + var.availability_zones)
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    "Name"                                                           = "${var.customer_name}-${var.project_name}-private-${data.aws_availability_zones.available.names[count.index]}"
    "kubernetes.io/role/internal-elb"                                = "1"
    "kubernetes.io/cluster/${var.customer_name}-${var.project_name}" = "owned"
  }
}

resource "aws_eip" "main" {
  vpc = true

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.main.id
  subnet_id     = aws_subnet.public[0].id

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-public"
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    "Name" = "${var.customer_name}-${var.project_name}-private"
  }
}

resource "aws_route_table_association" "public" {
  count = var.availability_zones

  route_table_id = aws_route_table.public.id
  subnet_id      = aws_subnet.public[count.index].id
}

resource "aws_route_table_association" "private" {
  count = var.availability_zones

  route_table_id = aws_route_table.private.id
  subnet_id      = aws_subnet.private[count.index].id
}