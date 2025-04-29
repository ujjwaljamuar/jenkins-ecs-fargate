# Backend configuration (optional, if using remote state like S3)
terraform {
  backend "s3" {
    bucket = "uj-terraform-state-files"
    key    = "jenkins-ecs-fargate/terraform.tfstate" 
    region = "ap-south-1"  
  }
}

module "ecs-fargate" {
  source = "./modules/ecs_fargate"
  ecs_cluster_name = var.ecs_cluster_name
  lambda_role = var.lambda_role
  vpc_id var.vpc_id
}


module "lambda" {
  source = "./modules/lambda"
  lambda_role = var.lambda_role
}