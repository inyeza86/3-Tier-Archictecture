# Create an IAM Role
resource "aws_iam_role" "ec2_s3_access_role" {
  name = "ec2-s3-access-role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17",
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          Service : "ec2.amazonaws.com"
        },
        Action : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "ec2_s3_access_role"
  }
}

# Attach S3 Full Access Policy to the IAM Role
resource "aws_iam_policy_attachment" "s3_full_access" {
  name       = "s3-full-access-attachment"
  roles      = [aws_iam_role.ec2_s3_access_role.name]
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Create an IAM Instance Profile
resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "ec2-s3-instance-profile"
  role = aws_iam_role.ec2_s3_access_role.name
}

# Security Group for EC2
# resource "aws_security_group" "ec2_sg" {
#   vpc_id = aws_vpc.main.id

#   ingress {
#     from_port   = 22
#     to_port     = 22
#     protocol    = "tcp"
#     cidr_blocks = ["0.0.0.0/0"] # Adjust as per your requirements
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "EC2 Security Group"
#   }
# }
