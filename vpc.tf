resource "aws_vpc" "mytfvpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mytfvpc"
  }
}

resource "aws_internet_gateway" "mytfgw" {
  vpc_id = "${aws_vpc.mytfvpc.id}"

  tags = {
    Name = "mytfgw"
  }
}

resource "aws_subnet" "subnet" {
  count                   = "${length(var.subnet_cidr)}"
  vpc_id                  = "${aws_vpc.mytfvpc.id}"
  availability_zone       = "${element(var.azs,count.index)}"
  cidr_block              = "${element(var.subnet_cidr,count.index)}"
  map_public_ip_on_launch = true

  tags = {
    Name = "subnet-{count.index +1}"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.mytfvpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.mytfgw.id}"
  }

  tags = {
    Name = "RT"
  }
}

resource "aws_route_table_association" "a" {
  count          = "${length(var.subnet_cidr)}"
  subnet_id      = "${element(aws_subnet.subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.rt.id}"
}
