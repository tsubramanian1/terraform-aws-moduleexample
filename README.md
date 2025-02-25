# My first Module
This solve all your infrastructure needs.
## usage
```
module "my_vpc_module" {
  source = "github.com/tsubramanian1/tf_module_example"

  aws_region = "us-east-1"

aws_availability_zone_one = "us-east-1c"
aws_availability_zone_two = "us-east-1d"

vpc_cidr_block = "10.0.0.0/16"
subnet_a_cidr_block = "10.0.1.0/24"
subnet_b_cidr_block = "10.0.2.0/24"

ec2_instance_ami_id = "ami-053a45fff0a704a47"
ec2_instance_type = "t2.micro"
ec2_instance_name_one = "devwebinstance1"
ec2_instance_name_two = "devwebinstance2"
number_of_instances = 1

}
```