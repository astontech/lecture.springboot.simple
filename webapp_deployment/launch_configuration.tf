resource "aws_launch_configuration" "as_conf" {
  name_prefix   = "${var.application_name}-node-"
  image_id      = var.worker_ami
  instance_type = "t2.micro"
  iam_instance_profile = var.instance_profile
  user_data = <<EOF
#! /bin/bash
aws s3 cp s3://${var.artifact_bucket}/${var.application_version} ./ --recursive
sudo java -jar *.jar
EOF

  security_groups = [aws_security_group.application_server_security_group.id]

  key_name = "testinstance-rsa"



  lifecycle {
    create_before_destroy = true
  }
}
