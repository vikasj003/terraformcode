resource "aws_elb" "myelb" {
  name               = "myelb"
  availability_zones = ["${var.azs}"]
  security_groups    = ["${aws_security_group.allow_http.id}"]
  subnets             = ["${aws_subnet.subnet.*.id}"]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 10
  }

  instances                   = ["${aws_instance.web.*.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "myelb"
  }
}
