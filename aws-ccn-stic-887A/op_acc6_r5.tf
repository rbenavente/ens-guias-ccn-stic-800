resource "prismacloud_policy" "op_acc6_r5" {
   name = "Usuario de AWS IAM tiene acceso a la consola y claves de acceso"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica a los usuarios de IAM que tienen acceso a la consola y claves de acceso. Cuando se crea un usuario de IAM, el administrador puede asignar acceso a la consola, claves de acceso o ambos. Idealmente, el acceso a la consola debería asignarse a los usuarios y las claves de acceso para las aplicaciones del sistema/API, pero no ambos al mismo usuario de IAM.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Usuario de AWS IAM tiene acceso a la consola y claves de acceso"
        criteria = "config from cloud.resource where cloud.type ='aws' and api.name = 'aws-iam-get-credential-report' AND json.rule = 'password_enabled is true and (access_key_1_active is true or access_key_2_active is true)'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'.
2. Identifique al usuario de IAM denunciado.
3. En la pestaña 'Credenciales de seguridad' verifique la presencia de claves de acceso.
4. Según los requisitos y la política de la empresa, elimine las claves de acceso o elimine el acceso a la consola para este usuario de IAM.
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



