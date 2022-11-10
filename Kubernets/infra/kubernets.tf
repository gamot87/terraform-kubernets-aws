
#Recursos do kubetnets

resource "kubernetes_deployment" "Django-API" {
  metadata {
    name = "django-api"
    labels = {
      nome = "django"
    }
  }

  spec {
    replicas = 3 #numero de aplicações (maquinas)

    selector {
      match_labels = {
      nome = "django"
      }
    }

    template {
      metadata {
        labels = {
          nome = "django"
        }
      }

      spec {
        container {
          image = "caminho da imagem no ecr ou no dockerhub"
          name  = "django"

          resources { #Recursos computacionais que serão utilizados para a rodas a aplicação
            limits = {
              cpu    = "0.5"
              memory = "512Mi"
            }
            requests = {
              cpu    = "250m"
              memory = "50Mi"
            }
          }

          liveness_probe { #ajuda a ver o estado atual da nossa aplicação (travada ou respondendo as requisições) 3 falhas e ele derruba o pod e sobe outro
            http_get {
              path = "/clientes/"
              port = 8000

              #http_header {
                #name  = "X-Custom-Header" #customizar o cabeçalho da nossa requisição
                #value = "Awesome"
              #}
            }

            initial_delay_seconds = 3 #tempo para começar a liveness probe
            period_seconds        = 3 #frequencia 
          }
        }
      }
    }
  }
}



resource "kubernetes_service" "loagbalancer" { #loader balancer 
  metadata {
    name = "loadbalancer-django-api"
  }
  spec {
    selector = {
      nome = "django"
    }
    port {
      port        = 8000 #porta da máquina
      target_port = 8000 #porta do container
    }
    type = "LoadBalancer"
  }
}
locals { #codigo para recebermos as informações relativas ao load balancer (DNS por exemplo)
  lb_name = split("-", split(".", kubernetes_service.loagbalancer.status.0.load_balancer.0.ingress.0.hostname).0).0
}


data "aws_elb" "nomeDNS" {
  name = local.lb_name
}

output "URL" {
  value = data.aws_elb.nomeDNS
}



