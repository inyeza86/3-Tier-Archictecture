# Create an EC2 Instance
resource "aws_instance" "data-migration-ec2" {
  ami                    = "ami-012967cc5a8c9f891" # Replace with your desired AMI
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.my_private_subnet1.id
  iam_instance_profile   = aws_iam_instance_profile.ec2_instance_profile.name
  vpc_security_group_ids = [aws_security_group.data-migration-server-sg.id]

  tags = {
    Name = "Data-migration-EC2"
  }
}
