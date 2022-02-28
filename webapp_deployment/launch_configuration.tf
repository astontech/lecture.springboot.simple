resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "${var.application_name}-node-"
  image_id      = var.worker_ami
  instance_type = "t2.micro"

  // TODO - update userdata script for running spring application, add command to get S3 command where bucket folder = application_version
  // Example -  aws s3 cp s3://my_bucket/${var/my_file.ext my_copied_file.ext
  user_data = <<EOF
#! /bin/bash
mkdir webapp && cd webapp
touch index.html && echo "<h1>Hello World!</h1><br> app version ${var.application_version}" > index.html
python3 -m http.server
EOF

  security_groups = [aws_security_group.application_server_security_group.id]



  lifecycle {
    create_before_destroy = true
  }
}
