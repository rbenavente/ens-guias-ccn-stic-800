resource "prismacloud_policy" "op_acc6_r12" {
   name = "AWS CloudTrail está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Comprueba que CloudTrail esté habilitado en la cuenta. AWS CloudTrail es un servicio que permite la gobernanza, el cumplimiento, la auditoría operativa y de riesgos de la cuenta de AWS. Es una práctica recomendada de cumplimiento y seguridad activar CloudTrail para obtener un seguimiento de auditoría completo de las actividades en varios servicios.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS CloudTrail está deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-cloudtrail-describe-trails' as X; count(X) less than 1"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'CloudTrail'.
2. Siga las instrucciones a continuación para habilitar CloudTrail en la cuenta.
http://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-create-and-update-a-trail.html

EOT
   remediation {
      cli_script_template = "aws cloudtrail start-logging --name 'resourceName' --region 'region'"
      description = "Este comando CLI requiere el permiso 'cloudtrail:StartLogging'. La ejecución exitosa permitirá el registro para el CloudTrail respectivo."
   }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



