module "vpc" {
  source = "./modules/vpc"
  region = var.region
  env    = var.env
}

module "eks" {
  source     = "./modules/eks"
  vpc_id     = module.vpc.vpc_id
  subnets    = module.vpc.private_subnets
  cluster_name = "eks-${var.env}"
}

module "ecs" {
  source  = "./modules/ecs"
  vpc_id  = module.vpc.vpc_id
  subnets = module.vpc.private_subnets
}

module "rds" {
  source      = "./modules/rds"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.db_subnets
  db_user     = var.db_user
  db_password = var.db_password
}

module "s3" {
  source = "./modules/s3"
  bucket_name = "my-app-storage-${var.env}"
}
