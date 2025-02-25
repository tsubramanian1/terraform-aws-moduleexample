variable "aws_region" {
  type        = string
  description = "The aws region where creating a infrastructure"
}

variable "aws_availability_zone_one" {
  type        = string
  description = "The aws availability zone one where we deploy the vm"
}

variable "aws_availability_zone_two" {
  type        = string
  description = "The aws availability zone two where we deploy the vm"
}

variable "vpc_cidr_block" {
  type        = string
  description = "The vpc cidr block "
}

variable "subnet_a_cidr_block" {
  type        = string
  description = "The subnet a cidr block "
}

variable "subnet_b_cidr_block" {
  type        = string
  description = "The subnet b cidr block "
}

variable "ec2_instance_type" {
  type        = string
  default     = "t2.micro"
  description = "This is the AWS EC2 Instance type / size to use."
}

variable "ec2_instance_name_one" {
  type        = string
  description = "The name give to EC2 Instance name one"
}

variable "ec2_instance_name_two" {
  type        = string
  description = "The name give to EC2 Instance name two"
}

variable "ec2_instance_ami_id" {
  type        = string
  description = "The AMI ID to launch the instance. NB: These differ between each region"
}

variable "number_of_instances" {
  type        = number
  description = "The no of instance to launch"
}
