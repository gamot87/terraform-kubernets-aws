#modulo para criação da infraestrutura.

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "VPC-ECS"
  cidr = "10.0.0.0/16" # faixa de endereços 10.0.1.1 até 10.0.255.255

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.5.0/24", "10.0.6.0/24", "10.0.7.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true #ativar o natgateway para que a aplicação na rede privada possa receber e enviar requisições de fora.
  enable_vpn_gateway = false

}

