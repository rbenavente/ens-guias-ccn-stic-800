resource "prismacloud_policy" "op_acc6_r8" {
   name = "AWS AccessKey activa para la cuenta root"
   policy_type = "config"
   cloud_type = "aws"
   severity = "high"
   description = <<-EOT
Esta política identifica las cuentas raíz para las cuales las claves de acceso están habilitadas. Las claves de acceso se utilizan para firmar solicitudes de API a AWS. Las cuentas raíz tienen acceso completo a todos sus servicios de AWS. Si la clave de acceso de una cuenta raíz se ve comprometida, los usuarios no autorizados tendrán acceso completo a su cuenta de AWS.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS AccessKey activa para la cuenta root"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-iam-get-account-summary' AND json.rule='not AccountAccessKeysPresent equals 0'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS como usuario raíz.
2. Haga clic en el nombre de la cuenta raíz y en la parte superior derecha seleccione 'Credenciales de seguridad' en el menú desplegable.
3. Para cada clave en 'Claves de acceso', haga clic en "X" para eliminar las claves.
EOT
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id # op.acc6 Compliance Section UUID

   }

}



