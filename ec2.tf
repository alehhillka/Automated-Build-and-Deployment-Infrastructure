provider "aws" {
  region = "eu-central-1" 
}

resource "aws_instance" "project" {
  count = 1
  ami           = "ami-0427a796a4e582276" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.project.id]
  subnet_id = module.vpc.public_subnets[0]
  key_name      = "ssh" 
  user_data     = base64encode(file("userdata.sh"))
   associate_public_ip_address = true
    iam_instance_profile = aws_iam_instance_profile.project_profile.name
    
  tags = {
    "Name" = "project_1"
  }
 
}
