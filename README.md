# My first Module
This solve all your infrastructure needs.
## usage
Sample usage
```
module "my_vpc_module" {
  source = "github.com/tsubramanian1/tf_module_example"

  aws_region = "<mention your region name>"

aws_availability_zone_one = "<mention your first availability name>"
aws_availability_zone_two = "<mention your second availability name>"

vpc_cidr_block = "<mention your vpc cdir block>"
subnet_a_cidr_block = "<mention your subnet a cdir block>"
subnet_b_cidr_block = "<mention your subnet a cdir block>"

ec2_instance_ami_id = "<mention your instance ami id>"
ec2_instance_type = "t2.micro"
ec2_instance_name_one = "<mention your first instance name>"
ec2_instance_name_two = ""<mention your second instance name>""
number_of_instances = 1

}
```