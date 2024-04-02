resource "prismacloud_policy" "op_acc6_r2" {
   name = "Clave de acceso de AWS que no ha rotado en los ultimos 90 días"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica a los usuarios de IAM cuyas claves de acceso no se rotan durante 90 días. Las claves de acceso se utilizan para firmar solicitudes de API a AWS. Como práctica recomendada de seguridad, se recomienda rotar periódicamente todas las claves de acceso para garantizar que, en caso de que la clave se vea comprometida, los usuarios no autorizados no puedan obtener acceso a sus servicios de AWS.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clave de acceso de AWS que no ha rotado en los ultimos 90 días"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-iam-get-credential-report' AND json.rule = '(access_key_1_active is true and access_key_1_last_rotated != N/A and _DateTime.ageInDays(access_key_1_last_rotated) > 90) or (access_key_2_active is true and access_key_2_last_rotated != N/A and _DateTime.ageInDays(access_key_2_last_rotated) > 90)'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'.
2. Haga clic en el usuario que fue reportado en la alerta.
3. Haga clic en 'Credenciales de seguridad' y en cada 'Clave de acceso'.
4. Siga las instrucciones a continuación para rotar las claves de acceso que tengan más de 90 días.
https://aws.amazon.com/blogs/security/how-to-rotate-access-keys-for-iam-users/
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



