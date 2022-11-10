module "producao" {
  source = "../../infra"

  nome_producao = "producao"
  cluster_name = "producao"
  }
output "endereco" { #a saida sera exibida atravez desse codigo
  value = module.producao.URL
  }


