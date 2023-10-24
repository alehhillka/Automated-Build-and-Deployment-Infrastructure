# Створення Launch Template
resource "aws_launch_template" "project" {
  name_prefix   = "project-lt"
  image_id      = "ami-0ce898befc315637f" 
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.lb_sg.id]
  key_name = "ssh"
   user_data = base64encode(
  <<-EOF
#!/bin/bash
sudo  service docker start
docker-compose up -d
cd /home/ec2-user
docker-compose -f /home/ec2-user/docker-compose.yml up -d
  EOF
)
  iam_instance_profile {
    name = aws_iam_instance_profile.project_profile.name
  }

}

# Створення Auto Scaling Group (ASG)
resource "aws_autoscaling_group" "project" {
  name             = "project-asg"
  min_size         = 3
  max_size         = 3
  desired_capacity = 3
  
  launch_template {
    id      = aws_launch_template.project.id
    version = aws_launch_template.project.latest_version
  }
  
  vpc_zone_identifier = [module.vpc.private_subnets[0]]  # Приватна підмережа, де буде розміщено екземпляри
  health_check_type  = "EC2"
}

# Створення Security Group для Auto Scaling Group
resource "aws_security_group" "asg_security_group" {
  name_prefix = "asg-"
  description = "Security Group for Auto Scaling Group"
  vpc_id = module.vpc.vpc_id # Встановіть відповідну ідентифікаційну інформацію про вашу VPC
}



