resource "prismacloud_policy" "op_exp8_r2" {
   name = "Los logs de seguimiento de AWS CloudTrail no están integrados con CloudWatch Log"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica AWS CloudTrail que tiene logs de seguimiento que no están integrados con CloudWatch Log. Habilitar los registros de seguimiento de CloudTrail integrados con CloudWatch Logs permitirá el registro de actividad histórico y en tiempo real. Esto mejorará aún más la capacidad de monitoreo y alarma.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Los logs de seguimiento de AWS CloudTrail no están integrados con CloudWatch Log"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudtrail-describe-trails' AND json.rule = 'cloudWatchLogsRoleArn equals null or cloudWatchLogsRoleArn does not exist' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la Consola de administración de AWS y acceda al servicio CloudTrail.
2. Haga clic en Senderos en el menú de la izquierda.
3. Haga clic en el CloudTrail identificado y navegue hasta la sección 'Registros de CloudWatch'.
4. Haga clic en la pestaña 'Configurar' y proporcione los requisitos
5. Proporcione un nombre de grupo de registros en el campo "Grupo de registros nuevo o existente".
6. Haga clic en 'Continuar'
7. En la página siguiente, en el menú desplegable 'Rol de IAM', seleccione un rol de IAM con el acceso requerido o seleccione 'Crear un nuevo rol de IAM'.
8. Haga clic en 'Permitir'
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id# op.exp8 Compliance Section UUID

  }
 compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

  }
}



