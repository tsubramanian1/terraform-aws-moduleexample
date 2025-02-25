resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block
}

resource "aws_subnet" "subnet_a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_a_cidr_block
  availability_zone       = var.aws_availability_zone_one
  map_public_ip_on_launch = true
}

resource "aws_subnet" "subnet_b" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_b_cidr_block
  availability_zone       = var.aws_availability_zone_two
  map_public_ip_on_launch = true
}

resource "aws_security_group" "alb_sg" {
  name        = "alb_sg"
  description = "Security group for ALB"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_security_group" "instance_sg" {
  name        = "instance_sg"
  description = "Security group for instances"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
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

resource "aws_internet_gateway" "my_internet_gateway" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "My-Internet-Gateway"
  }
}
resource "aws_route_table" "my_public_rt" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route" "internet_route" {
  route_table_id         = aws_route_table.my_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.my_internet_gateway.id
}

# Associate the route table with the subnet a
resource "aws_route_table_association" "subneta_association" {
  subnet_id      = aws_subnet.subnet_a.id
  route_table_id = aws_route_table.my_public_rt.id
}

# Associate the route table with the subnet b
resource "aws_route_table_association" "subnetb_association" {
  subnet_id      = aws_subnet.subnet_b.id
  route_table_id = aws_route_table.my_public_rt.id
}

resource "aws_lb" "main" {
  name               = "main-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = [aws_subnet.subnet_a.id, aws_subnet.subnet_b.id]
}

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}


resource "aws_instance" "web1" {
  ami             = var.ec2_instance_ami_id # Use a valid AMI for your region
  instance_type   = var.ec2_instance_type
  security_groups = [aws_security_group.instance_sg.id]
  subnet_id       = aws_subnet.subnet_a.id
  tags = {
    Name = var.ec2_instance_name_one
  }
  user_data = file("httpd_web_server.sh")
}

resource "aws_instance" "web2" {
  ami             = var.ec2_instance_ami_id # Use a valid AMI for your region
  instance_type   = var.ec2_instance_type
  security_groups = [aws_security_group.instance_sg.id]
  subnet_id       = aws_subnet.subnet_b.id
  tags = {
    Name = var.ec2_instance_name_two
  }
  user_data = file("httpd_web_server.sh")
}



resource "aws_lb_target_group_attachment" "web1_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web1.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "web2_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = aws_instance.web2.id
  port             = 80
}
