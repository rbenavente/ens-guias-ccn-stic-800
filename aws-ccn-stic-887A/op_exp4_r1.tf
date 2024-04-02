resource "prismacloud_policy" "op_exp4_r1" {
   name = "AWS Guardduty está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Amazon GuardDuty es un servicio de monitoreo de seguridad que analiza y Orígenes de datos fundamentales procesa, por ejemploAWS CloudTrail, los eventos de administración deAWS CloudTrail, los registros de flujo de VPC (de instancias Amazon EC2) de y los registros de DNS.
Las buenas prácticas recomiendan desplegar a nivel de sistema una estrategia de monitorización continua de amenazas y vulnerabilidades detallando: indicadores críticos de seguridad, política de aplicación de parches y criterios de revisión regular y excepcional de amenazas del sistema.
		
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Guardduty está deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-guardduty-detector' AND json.rule = status equals \"DISABLED\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la documentación para activar Guardduty: https://docs.aws.amazon.com/es_es/guardduty/latest/ug/guardduty_settingup.html
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp4.csrs_id # op.exp4 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp6.csrs_id# op.exp6 Compliance Section UUID

  }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp7.csrs_id# op.exp7 Compliance Section UUID

  }
   
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon1.csrs_id # op.mon1 Compliance Section UUID

   }

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

   }

}



