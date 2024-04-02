resource "prismacloud_policy" "op_acc3_r3" {
   name = "Politica de AWS IAM SecurityAudit no esta asingnada a ningun rol"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las políticas de IAM con acceso a permisos de Auditoria que no están asociadas a ningun rol para una cuenta. AWS proporciona un centro de soporte que se puede utilizar para notificación y respuesta a incidentes, así como soporte técnico y servicios al cliente.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Politica de AWS IAM SecurityAudit  aplicada a usuarios"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-policy-version' AND json.rule = 'policyName equals SecurityAudit and policyArn contains arn:aws:iam::aws:policy/SecurityAudit and (isAttached is false or (isAttached is true and entities.policyRoles[*].roleId is empty))'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
   Disponer de cuentas con privilegios de auditoría estrictamente controladas y personalizadas para ello:
1. Inicie sesión en la consola de AWS
2.Vaya al servicio IAM en el panel Servicios.
3.Desde el panel izquierdo, haga clic en 'Políticas'
4.Buscar la existencia de una política de soporte 'SecurityAudit'
5.Crear un rol de IAM
6. Adjunte la política administrada 'SecurityAudit' al rol de IAM creado
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc3.csrs_id  # op.acc3 Compliance Section UUID

   }

}



