module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "playsdev-eks"
  cluster_version = "1.20"
  subnets         = [aws_subnet.playsdev-public-subnet.id,aws_subnet.playsdev-public-subnet-2.id]	

  tags = {
    Environment = "training"
    GithubRepo  = "terraform-aws-eks"
    GithubOrg   = "terraform-aws-modules"
  }

  vpc_id = aws_vpc.playsdev_vpc.id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "worker-group-1"
      instance_type                 = "t2.small"
      additional_userdata           = "echo foo bar"
      asg_desired_capacity          = 2
      additional_security_group_ids = [aws_security_group.playsdev-sg.id]
    }
  ]
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}



