resource "prismacloud_policy" "op_mon3_r3" {
   name = "AWS Elastic Load Balancer (clásico) con el registro de acceso deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los Classic Elastic Load Balancers que tienen el registro de acceso deshabilitado. Cuando el registro de acceso está habilitado, el balanceador de carga clásico captura información detallada sobre las solicitudes enviadas a su balanceador de carga. Cada registro contiene información como la hora en que se recibió la solicitud, la dirección IP del cliente, latencias, rutas de solicitud y respuestas del servidor. Puede utilizar estos registros de acceso para analizar patrones de tráfico y solucionar problemas.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Elastic Load Balancer (clásico) con el registro de acceso deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elb-describe-load-balancers' AND json.rule = 'attributes.accessLog.enabled is false' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar el registro de acceso para Elastic Load Balancer (Classic), siga la URL que se menciona a continuación:
https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-access-logs.html'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

  }
 
   
}



