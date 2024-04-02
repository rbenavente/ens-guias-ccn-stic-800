resource "prismacloud_policy" "op_exp4_r2" {
   name = "AWS Inspector está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Amazon Inspector es un servicio de administración de vulnerabilidades que analiza de forma continua las cargas de trabajo de AWS en busca de vulnerabilidades de software y exposiciones de red no deseadas.
Las buenas prácticas recomiendan desplegar a nivel de sistema una estrategia de monitorización continua de amenazas y vulnerabilidades detallando: indicadores críticos de seguridad, política de aplicación de parches y criterios de revisión regular y excepcional de amenazas del sistema.
		
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Inspector está deshabilitado"
        criteria = "config from cloud.resource where api.name = 'aws-inspector-v2-account-status' AND json.rule = accounts[*].state equals DISABLED"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la documentación para activar Inspector: https://docs.aws.amazon.com/es_es/inspector/latest/user/what-is-inspector.html
EOT

   compliance_metadata {
      compliance_id =prismacloud_compliance_standard_requirement_section.opexp4.csrs_id # op.exp4 Compliance Section UUID

   }
  
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

   }

}



