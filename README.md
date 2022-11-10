# terraform-kubernets-aws
Subindo uma infraestutura e uma aplicação(django) com terraform na aws em clusters orquestrado pelo kubernets. 


Para executar esse projeto basta baixar os arquivos desse repositório e abrir a pasta no vscode e seguir as instruções abaixo :
* link da api django, dando os devidos creditos ao senhor guilherme, criador da mesma: https://github.com/guilhermeonrails/clientes-leo-api.git 
*requerimentos: conta AWS, terraform, docker e cli instalados

*Fazer login na aws via CLI -aws configure e preencher os dados com as chaves criadas para seu usuário na aws ou gerar chaves ssh e cadastrar em seu usuario aws na ec2
*Criar ou usar um bucketS3 existente.

* preencher aqruivo Prod/Backend.tf - key = caminho e nome do arquivo que será salvo no S3 (terraform.tfstate)
                          region = região de sua preferência
                          bucket = nome do bucket criado
                          
* preencher arquivo infra/Kubernets,tf - em resource_deployment deve-se indicar qual imagem(container) no seu ecr será utilizada no dploy , para isso deve-se configurar o campo image :
  spec {
        container {
          image = "caminho da imagem no ecr "
          
*Criar uma imagem docker com uma aplicação django e executar o docker push para o repósitório Ecr criado ou existente na AWS.

*Após efetuar os passos acima abrir um terminal no vs code na pasta Prod e executar terraform init , terraform init -upgrade- ,terraform plan e se não houverem erros usar o comando terraform apply e posteriormente o yes. 


          
 

