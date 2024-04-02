resource "prismacloud_policy" "op_acc3_r2" {
   name = "Politica de AWS IAM de soporte no esta asingnada a ningun rol"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las políticas de IAM con acceso a permisos de soporte que no están asociadas a ningun rol para cuentas de usuarios. AWS proporciona un centro de soporte que se puede utilizar para notificación y respuesta a incidentes, así como soporte técnico y servicios al cliente.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Politica de AWS IAM de soporte no esta asingnada a ningun rol"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-policy-version' AND json.rule = 'policyName equals AWSSupportAccess and policyArn contains arn:aws:iam::aws:policy/AWSSupportAccess and (isAttached is false or (isAttached is true and entities.policyRoles[*].roleId is empty))'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2.Vaya al servicio IAM en el panel Servicios.
3.Desde el panel izquierdo, haga clic en 'Políticas'
4.Buscar la existencia de una política de soporte 'AWSSupportAccess'
5.Crear un rol de IAM
6. Adjunte la política administrada 'AWSSupportAccess' al rol de IAM creado
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc3.csrs_id  # op.acc3 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opext2.csrs_id  # op.ext2 Compliance Section UUID

  }
}



