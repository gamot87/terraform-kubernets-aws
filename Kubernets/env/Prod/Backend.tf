
#backend da aplicação
erraform {
  backend "s3" {
    bucket = "nome do bucket"
    key    = "<pasta-atual>/terraform.tfstate" #caminho e nome do arquivo que vamos guardar no bucket
    region = "regiao de escolha"
    
  }
}