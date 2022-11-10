#Modulo do kubernets

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 18.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.23"

  cluster_endpoint_private_access = true #permite mudar configuraçoes e implementar as aplicações no cluster
  #cluster_endpoint_public_access  = true #nao usaremos o acesso publico

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets


  # Self Managed Node Group(s) #Não vamos usar pois essa configuração é necessario configurar as maquinas configuradas manualmente
#   self_managed_node_group_defaults = {
#     instance_type                          = "m6i.large"
#     update_launch_template_default_version = true
#     iam_role_additional_policies = [
#       "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
#     ]
#   }

#   self_managed_node_groups = {
#     one = {
#       name         = "mixed-1"
#       max_size     = 5
#       desired_size = 2

#       use_mixed_instances_policy = true
#       mixed_instances_policy = {
#         instances_distribution = {
#           on_demand_base_capacity                  = 0
#           on_demand_percentage_above_base_capacity = 10
#           spot_allocation_strategy                 = "capacity-optimized"
#         }

#         override = [
#           {
#             instance_type     = "m5.large"
#             weighted_capacity = "1"
#           },
#           {
#             instance_type     = "m6i.large"
#             weighted_capacity = "2"
#           },
#         ]
#       }
#     }
#   }



   # configuralçoes default
   eks_managed_node_group_defaults = {
     
     instance_types = ["t2.micro"] #tipo da instância(essa é free tier)
      min_size     = 1
      max_size     = 10
      desired_size = 3
   }

  eks_managed_node_groups = {
    alura= {
    green = {
      min_size     = 1
      max_size     = 10
      desired_size = 3
      vpc_security_group_ids = [aws_security_group.ssh_cluster.id] 
      instance_types = ["t2.micro"]
      #capacity_type  = "SPOT" nao usaremos esse modelo de instancia (solicitar instancias ec2 nao usadas com descontos mas que podem ser requisitadas pela aws a qualquer momento,
      # interessante para situações onde não é necessario que a aplicação fique online o tempo todo e de baixa criticidade)
    }
  }

}
}