terraform {
  required_version = ">= 0.13"
}

provider "aws" {
  region = var.aws_region
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    #organization = var.tfc_org_name
    organization = "two-tier-demo"
    workspaces = {
          #name = var.tfc_network_workspace_name
          name = "network"
    }
  }
}

locals {
  availability_zones = split(",", var.availability_zones)
}

resource "aws_elb" "web-elb" {
  name = "techex-example-elb"
  subnets         = data.terraform_remote_state.network.outputs.public_subnet_ids
  security_groups = data.terraform_remote_state.network.outputs.elb_security_group_ids
  #instances       = [aws_instance.web.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/"
    interval            = 30
  }
}

resource "aws_autoscaling_group" "web-asg" {
  #availability_zones   = local.availability_zones
  name                 = "techex-example-asg"
  max_size             = var.asg_max
  min_size             = var.asg_min
  desired_capacity     = var.asg_desired
  force_delete         = true
  launch_configuration = aws_launch_configuration.web-lc.name
  load_balancers       = [aws_elb.web-elb.name]
  vpc_zone_identifier  = data.terraform_remote_state.network.outputs.private_subnet_ids

  tag {
    key                 = "Name"
    value               = "web-asg"
    propagate_at_launch = "true"
  }
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_launch_configuration" "web-lc" {
  name          = "techex-example-web"
  image_id      = var.image_id
  instance_type = var.instance_type

  # Security group
  security_groups = data.terraform_remote_state.network.outputs.app_instance_security_group_ids
  # Assign private key 
  key_name        = aws_key_pair.generated_key.key_name
}