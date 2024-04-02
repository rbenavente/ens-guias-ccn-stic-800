resource "prismacloud_policy" "op_acc6_r15" {
   name = "Usuario AWS  sin permiso para cambiar su contraseña"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Se debe permitir a los usuarios cambiar sus propias contraseñas.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Usuario AWS  sin permiso para cambiar su contraseña"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-account-password-policy' AND json.rule = allowUsersToChangePassword contains \"false\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'.
2. Haga clic en 'Configuración de la cuenta', marque 'Permitir a los usuarios cambiar la contraseña'

EOT
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



