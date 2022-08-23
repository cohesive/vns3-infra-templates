
module "vns3_vpc1" {
  providers = {
    aws = "aws.vpc1_region"
  }
  
  source              = "../../modules/aws-vns3-public"
  topology_name       = var.topology_name
  vns3_version        = var.vns3_version
  vns3_instance_type  = var.vns3_instance_type
  vpc_id              = module.aws_vpc1.vpc_id
  vpc_route_table_id  = module.aws_vpc1.route_table_id
  access_cidr         = var.access_cidr
  client_cidrs        = [var.vpc1_cidr, var.vpc2_cidr]
  subnet_ids          = length(module.aws_vpc1.subnet_ids) == 0 ? [] : slice(module.aws_vpc1.subnet_ids, 0, 2)
  common_tags         = var.common_tags
}


module "vns3_vpc2" {
  providers = {
    aws = "aws.vpc2_region"
  }

  source              = "../../modules/aws-vns3-public"
  topology_name       = var.topology_name
  vns3_version        = var.vns3_version
  vns3_instance_type  = var.vns3_instance_type
  vpc_id              = module.aws_vpc2.vpc_id
  vpc_route_table_id  = module.aws_vpc2.route_table_id
  access_cidr         = var.access_cidr
  client_cidrs        = [var.vpc2_cidr, var.vpc1_cidr]
  subnet_ids          = length(module.aws_vpc2.subnet_ids) == 0 ? [] : slice(module.aws_vpc2.subnet_ids, 0, 2)
  common_tags         = var.common_tags
}
