module "devops-Vpc" {
  source = "../modules"
  
  vpc_parameters = {
    vpc-1 = {
      name = "EKS-DevOps-${var.environment}"
      cidr_block = "10.0.0.0/24"
      enable_dns_hostnames = true
      enable_dns_support = true
      tags = {
        name = "eks-${var.environment}"
      }
    }
  }

  subnet_parameters = {
    sub-1 = {
      name = "public-subnet-${var.environments}"
      cidr_block = "10.0.0.0/27"
      vpc_name = "vpc-1"
      az = "us-east-1a"
      tags = {
        Name = "pub-sub-1-${var.environments}"
      }
    }
  }

  subnet_parameters = {
    sub-2 = {
      name = "public-subnet-${var.environments}"
      cidr_block = "10.0.0.32/27"
      vpc_name = "vpc-1"
      az = "us-east-1b"
      tags = {
        Name = "pub-sub-2-${var.environments}"
      }
    }
  }

  subnet_parameters = {
    sub-3 = {
      name = "public-subnet-${var.environments}"
      cidr_block = "10.0.0.64/24"
      vpc_name = "vpc-1"
      az = "us-east-1a"
      tags = {
        Name = "private-sub-1-${var.environments}"
      }
    }
  }

  subnet_parameters = {
    sub-4 = {
      name = "public-subnet-${var.environments}"
      cidr_block = "10.0.0.96/24"
      vpc_name = "vpc-1"
      az = "us-east-1b"
      tags = {
        Name = "pub-sub-4-${var.environments}"
      }
    }
  }
}

igw_parameters {
  igw-1 = {
    vpc_name = "vpc-1"
    tags = {
      Name = "igw-${var.environments}"
    }
  }
}

rt_parameters = {
  public-rt-1 ={
    subnet_name = "sub-1"
    tags = {
      Name = "pub-rt-${var.environments}"
    }
    routes = {
      destination_cidr_block = "0.0.0.0/0"
      use_igw = true
      gateway_id = "igw-1"
    }
  }

  public-rt-2 ={
    subnet_name = "sub-2"
    tags = {
      Name = "pub-rt-2-${var.environments}"
    }
    routes = {
      destination_cidr_block = "0.0.0.0/0"
      use_igw = false
      gateway_id = "igw-1"
    }
  }

  private-rt-1 ={
    subnet_name = "sub-3"
    tags = {
      Name = "pub-rt-${var.environments}"
    }
    routes = {
      destination_cidr_block = "0.0.0.0/0"
      use_igw = false
    }
  }

  private-rt-1 ={
    subnet_name = "sub-4"
    tags = {
      Name = "pub-rt-${var.environments}"
    }
    routes = {
      destination_cidr_block = "0.0.0.0/0"
      use_igw = false
    }
  }
}

