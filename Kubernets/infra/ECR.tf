#Criando nosso repositório para imagens docker na aws

resource "aws_ecr_repository" "repositorio" {
  name                 = var.nome_producao
}