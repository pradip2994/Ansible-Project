//Using variables Deploying IEC2 instances. 

//Deploying Ansible control node Instance

resource "aws_instance" "my_public_instance1" {
  ami           = var.ami1
  instance_type = var.instance_type1
  key_name      = "mydemokey"
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  
  tags = {
    Name = "Ansible control node"
  }
}

// Deploying Node-1 Instance

resource "aws_instance" "my_public_instance2" {
  ami           = var.ami1
  instance_type = var.instance_type1
  key_name      = "mydemokey"
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  
  tags = {
    Name = "Node-1"
  }
}

// Deploying Node-2 Instance

resource "aws_instance" "my_public_instance3" {
  ami           = var.ami1
  instance_type = var.instance_type1
  key_name      = "mydemokey"
  vpc_security_group_ids = [aws_security_group.server_security_group.id]
  
  tags = {
    Name = "Node-2"
  }
}

//Deploying instance Security group

resource "aws_security_group" "server_security_group" {
  name        = "ansible_security_group1"
  description = "enabled ssh, https and http ports"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
    
  tags = {
    Name = "Ansible_SG"
  }
}
