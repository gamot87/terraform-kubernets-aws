
#Criando o grupo de segurança para acesso ssh do cluster
resource "aws_security_group" "ssh_cluster" { 
  name        = "ssh_cluster"
  description = "Permite o trafego no cluster"
  vpc_id      = module.vpc.vpc_id
}

#regras de entrada
resource "aws_security_group_rule" "ssh_cluster_entrada" { 
  type              = "ingress" #entrada
  from_port         = 22 #porta dee acesso ssh
  to_port           = 22
  protocol          = "tcp" #protocolo tcp = protocolo de rede para fazer a comunicação - 0.0.0.0/0 - 255.255.255.255 qualquer ip 
  cidr_blocks       = ["0.0.0.0/0"]  #ips que podem vir as requisições
  security_group_id = aws_security_group.ssh_cluster.id #id do grupo de segurança no qual essas regras serão aplicadas
}

#regras de saída
resource "aws_security_group_rule" "ssh_cluster_saida" { #regras de saída
  type              = "egress" #saída
  from_port         = 0 #nossa aplicação vai responder a qualquer porta
  to_port           = 0
  protocol          = "-1" #protocolo = -1 libera para qualquer protocolo
  cidr_blocks       = ["0.0.0.0/0"]  #reponde para qualquer ip da internet
  security_group_id = aws_security_group.ssh_cluster.id #id do grupo de segurança no qual essas regras serão aplicadas
}

# #Criando o grupo de segurança para sub-redes privadas.
# resource "aws_security_group" "privado" {  # alb = aplication load balancer -- rede privada --
#   name        = "privado_ECS"
#   description = "configura o acesso do loader balance para a sub-rede privada"
#   vpc_id      = module.vpc.vpc_id
# }

# #regras de entrada
# resource "aws_security_group_rule" "entrada_ECS" { 
#   type              = "ingress" #entrada
#   from_port         = 0 #qualquer porta do loadBalancer
#   to_port           = 0
#   protocol          = "-1" #protocolo = -1 libera para qualquer protocolo vindo do loadbalancer
#   source_security_group_id = aws_security_group.alb.id # permite somente requisições permitidos pelo grupo de segurança do loadbalancer
#   security_group_id = aws_security_group.privado.id #id do grupo de segurança no qual essas regras serão aplicadas
# }

# #regras de saída
# resource "aws_security_group_rule" "saida_ECS" { 
#   type              = "egress" #entrada
#   from_port         = 0 #qualquer porta do loadBalancer
#   to_port           = 0
#   protocol          = "-1" #protocolo = -1 libera para qualquer protocolo vindo do loadbalancer
#   cidr_blocks       = ["0.0.0.0/0"]  #reponde para qualquer ip da internet
#   security_group_id = aws_security_group.privado.id #id do grupo de segurança no qual essas regras serão aplicadas
# }

