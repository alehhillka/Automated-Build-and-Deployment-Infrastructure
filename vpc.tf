module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "project_1"
  cidr = "10.0.0.0/16"

  azs = ["eu-central-1a", "eu-central-1b", "eu-central-1c"] 

  private_subnets = ["10.0.1.0/24"]
  public_subnets = ["10.0.4.0/24"]

 
}
resource "aws_security_group" "project" {
  vpc_id = module.vpc.vpc_id

  
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}