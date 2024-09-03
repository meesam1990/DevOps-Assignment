# Generate KeyPair
resource "aws_key_pair" "eks_keypair" {
  key_name   = "eks-keypair"
  public_key = file("${path.module}/eks-keypair.pub")
}

# Output the key name to be used in the EKS module
output "keypair_name" {
  value = aws_key_pair.eks_keypair.key_name
}

# Provision vpc security group for the Bastion Host
resource "aws_security_group" "bastion_sg" {
  name        = "bastion-security-group"
  description = "Security group for SSH access to bastion host"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Bastion Security Group"
  }
}

# Provision bastion server to access eks cluster from local
resource "aws_instance" "bastion_host" {
  ami           = "ami-02b49a24cfb95941c"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.eks_keypair.key_name
  subnet_id     = module.vpc.public_subnets[0]  # Using the first public subnet
  associate_public_ip_address = true

  vpc_security_group_ids  = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "Bastion Host"
  }
}

# Worker node SG
resource "aws_security_group" "eks_workers_sg" {
  name        = "eks-worker-nodes-sg"
  description = "Security group for EKS worker nodes"
  vpc_id      = module.vpc.vpc_id

  # Allow SSH from the bastion host and the eks worker node
  ingress {
    description = "SSH from bastion host"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  # General egress rule: Allow all outbound
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EKS Worker Nodes SG"
  }
}

# Provision EKS cluster
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "20.24.0"
  cluster_name    = "ethereum-cluster"
  cluster_version = "1.30"
  subnet_ids      = module.vpc.private_subnets
  vpc_id          = module.vpc.vpc_id

  eks_managed_node_groups = {

    ethereum_nodes = {
      desired_capacity = 3
      max_capacity     = 5
      min_capacity     = 3

      instance_type = "t3.medium"
      key_name      = aws_key_pair.eks_keypair.key_name
  #    additional_security_group_ids = [aws_security_group.eks_workers_sg.id]
    }

    security_group_rules = {
      ingress_ec2_tcp = {
        description                = "Access EKS from EC2 instance."
        protocol                   = "tcp"
        from_port                  = 22
        to_port                    = 22
        type                       = "ingress"
        source_security_group_id   = aws_security_group.eks_workers_sg.id
    }
  }
  }

  tags = {
    Environment = "dev"
    Name        = "ethereum-cluster"
  }
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  value = module.eks.cluster_security_group_id
}

output "cluster_worker_node_sg_id" {
  value = aws_security_group.eks_workers_sg.id
}
