# Key Value pair

resource "aws_key_pair" "terra_key" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}


# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "TerraWeek-VPC"
  }
}

# -------------------------
# Subnet
# -------------------------
resource "aws_subnet" "sub_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "TerraWeek-Public-Subnet"
  }
}

# -------------------------
# Internet Gateway
# -------------------------
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "TerraWeek-IGW"
  }
}

# -------------------------
# Route Table
# -------------------------
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "TerraWeek-RT"
  }
}

# -------------------------
# Route Table Association
# -------------------------
resource "aws_route_table_association" "rta" {
  subnet_id      = aws_subnet.sub_public.id
  route_table_id = aws_route_table.rt.id
}


# -------------------------
# Security Group
# -------------------------
resource "aws_security_group" "my_security_group" {
  name        = "terra-security-group"
  vpc_id      = aws_vpc.my_vpc.id
  description = "this is Inbound and outbound rules for your instance Security group"

  tags = {
    Name = "TerraWeek-SG"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic" {
  security_group_id = aws_security_group.my_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}




# -------------------------
# EC2 Instance  ami-0c3389a4fa5bddaad
# -------------------------
resource "aws_instance" "my_instance" {  
  ami                         = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI (HVM), SSD Volume Type - us-east-1
  instance_type               = "t3.micro"
  key_name                    = aws_key_pair.terra_key.key_name
  subnet_id                   = aws_subnet.sub_public.id
  vpc_security_group_ids      = [aws_security_group.my_security_group.id]
  associate_public_ip_address = true

  # root storage (EBS)
  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }
  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name = "TerraWeek-Server"
  }
}

resource "aws_s3_bucket" "logs" {

  bucket = "terraweek-logs-bucket-12345"

  depends_on = [
    aws_instance.my_instance
    ]
}