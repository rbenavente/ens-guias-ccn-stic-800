resource "prismacloud_policy" "op_acc6_r1" {
   name = "Usuario AWS IAM con dos access Key activas"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica a los usuarios de IAM que tienen dos claves de acceso activas. Cada usuario de IAM puede tener hasta dos claves de acceso; tener dos claves en lugar de una puede aumentar las posibilidades de exposición accidental. Por lo tanto, es necesario garantizar que se eliminen las claves de acceso no utilizadas.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Usuario AWS IAM con dos access Key activas"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-iam-get-credential-report' AND json.rule = 'access_key_1_active is true and access_key_2_active is true'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'.
2. Haga clic en Usuarios en el panel de navegación.
3. Para el usuario de IAM identificado que tiene dos claves de acceso activas, según las políticas de su empresa, tome las medidas adecuadas.
4. Cree otro usuario de IAM con el objetivo específico realizado por la segunda clave de acceso.
5. Elimine una de las claves de acceso no utilizadas.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



