# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform from "eice-03ecab3f69e176649"
resource "aws_ec2_instance_connect_endpoint" "eice" {
  preserve_client_ip = false
  security_group_ids = [aws_security_group.ec2-instance-connect-endpoint-sg.id]
  subnet_id          = "subnet-0e0731b1d4939522c"
  tags = {
    Name = "DEV-EICE"
  }
}
