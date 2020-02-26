resource "aws_instance" "web" {
  count = "${length(var.subnet_cidr)}"
  ami = "${var.ami}"
  instance_type = "${var.instance_type}"
  security_groups = ["${aws_security_group.allow_http.id}"]
  subnet_id = "${element(aws_subnet.subnet.*.id,count.index)}"
  user_data = "${file("http.sh")}"
}
