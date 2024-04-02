resource "prismacloud_policy" "op_acc6_r11" {
   name = "El logging en AWS CloudTrail está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los CloudTrails en los que el registro está deshabilitado. AWS CloudTrail es un servicio que permite la gobernanza, el cumplimiento, la auditoría operativa y de riesgos de la cuenta de AWS. Es una práctica recomendada de cumplimiento y seguridad activar el registro de CloudTrail en diferentes regiones para obtener un seguimiento de auditoría completo de las actividades en varios servicios.

NOTA: Esta política se activará solo cuando tenga CloudTrail configurado en su cuenta de AWS y el registro esté deshabilitado.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "El logging de AWS CloudTrail está deshabilitado"
        criteria = "config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as X; config from cloud.resource where api.name = 'aws-cloudtrail-get-trail-status' as Y; filter '$.X.name equals $.Y.trail and $.Y.status.isLogging is false'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue al panel de CloudTrail
3. Haga clic en 'Senderos' (panel izquierdo)
4. Haga clic en CloudTrail informado.
5. Habilite el 'Registro' colocando el botón de registro en 'ON'

O
Si no se requiere CLoudTrail, puede eliminarlo haciendo clic en el icono de eliminación debajo del botón de desplazamiento de registro.

EOT
   remediation {
      cli_script_template = "aws cloudtrail start-logging --name 'resourceName' --region 'region'"
      description = "Este comando CLI requiere el permiso 'cloudtrail:StartLogging'. La ejecución exitosa permitirá el registro para el CloudTrail respectivo."
   }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id # op.acc6 Compliance Section UUID

   }

}



