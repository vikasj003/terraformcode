#!/bin/bash
yum install httpd -y
echo "<h1> Deployed by Terraform </h1>" > /var/www/html/index.html
chkconfig httpd on
servcie httpd start
