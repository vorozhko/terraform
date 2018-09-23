locals {
  cluster_name = "test-eks-cluster"

  # the commented out worker group list below shows an example of how to define
  # multiple worker groups of differing configurations
  # worker_groups = "${list(
  #                   map("asg_desired_capacity", "2",
  #                       "asg_max_size", "10",
  #                       "asg_min_size", "2",
  #                       "instance_type", "m4.xlarge",
  #                       "name", "worker_group_a",
  #                       "subnets", "${join(",", module.vpc.private_subnets)}",
  #                   ),
  #                   map("asg_desired_capacity", "1",
  #                       "asg_max_size", "5",
  #                       "asg_min_size", "1",
  #                       "instance_type", "m4.2xlarge",
  #                       "name", "worker_group_b",
  #                       "subnets", "${join(",", module.vpc.private_subnets)}",
  #                   ),
  # )}"

  worker_groups = "${list(
    map("instance_type","t2.medium",
      "additional_userdata","echo foo bar",
      "key_name","xps",
      "subnets", "${join(",", module.vpc.private_subnets)}",
    ),
    map("instance_type","t2.medium",
      "additional_userdata","echo foo bar",
      "key_name","xps",
      "subnets", "${join(",", module.vpc.private_subnets)}",
    )
  )}"
  tags = "${map("Environment", "test",
                "GithubRepo", "terraform-aws-eks",
                "GithubOrg", "terraform-aws-modules",
                "Workspace", "${terraform.workspace}",
  )}"
}

module "eks" {
  source                = "terraform-aws-modules/eks/aws"
  cluster_name          = "${local.cluster_name}"
  subnets               = ["${module.vpc.private_subnets}"]
  tags                  = "${local.tags}"
  vpc_id                = "${module.vpc.vpc_id}"
  worker_groups         = "${local.worker_groups}"
  worker_group_count    = "2"
  config_output_path	= "./.terraform/eks-config"

}
