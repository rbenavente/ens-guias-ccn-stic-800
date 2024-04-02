resource "prismacloud_policy" "mp_com3_r5" {
   name = "La política del bucket AWS S3 no esta restringia a solicitudes HTTPS"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica que el bucket de AWS S3 tiene una política que no aplica solo solicitudes HTTPS. Hacer cumplir que el bucket de S3 acepte solo solicitudes HTTPS evitaría que atacantes potenciales espiaran los datos en tránsito o manipularan el tráfico de la red mediante ataques de intermediario o similares. Se recomienda encarecidamente denegar explícitamente el acceso a las solicitudes HTTP en la política del bucket S3
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "La política del bucket AWS S3 no esta restringia a solicitudes HTTPS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-s3api-get-bucket-acl' AND json.rule = policy.Statement[?any(Effect equals Deny and Action equals s3:* and (Principal.AWS equals * or Principal equals *) and Condition.Bool.aws:SecureTransport contains false )] does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de S3.
3. Elija el depósito S3 informado
4. En la pestaña "Permisos", haga clic en "Editar" en "Política de depósito".
5. Para actualizar la política del depósito S3 para aplicar solo la solicitud HTTPS, siga la siguiente URL:
https://aws.amazon.com/premiumsupport/knowledge-center/s3-bucket-policy-for-config-rule/

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



