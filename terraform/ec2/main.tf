locals {
  project     = "practical-devops"
  environment = "dev"
  owner       = "SD5346"
}

module "jenkins-tags" {
  source = "../modules/tags"
  name   = "practical-devops-jenkin-tags"

  project     = local.project
  environment = local.environment
  owner       = local.owner
}

module "network" {
  source   = "../modules/network"
  name     = "practical-devops-network"
  vpc_cidr = "10.0.0.0/16"
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  # Filters for Amazon Linux 2
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security Group for Jenkins EC2
resource "aws_security_group" "jenkins_sg" {
  name        = "practical-devops-jenkins-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = module.network.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "jenkins" {
  key_name = var.jenkin_key_name

  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = "t3.medium"
  subnet_id                   = module.network.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.jenkins_sg.id]
  associate_public_ip_address = true

  user_data = file("init-jenkins.sh")

  tags = module.jenkins-tags.tags
}
