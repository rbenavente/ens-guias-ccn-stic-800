
resource "prismacloud_policy" "op_exp8_r13" {
   name = "AWS S3 bucket accesible para cualquier usuario autenticado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los buckets de S3 a los que puede acceder cualquier usuario de AWS autenticado. Amazon S3 permite al cliente almacenar y recuperar cualquier tipo de contenido desde cualquier lugar de la web. A menudo, los clientes tienen motivos legítimos para exponer el depósito S3 al público, por ejemplo, para alojar contenido de un sitio web. Sin embargo, estos depósitos a menudo contienen datos empresariales altamente confidenciales que, si se dejan accesibles a cualquier persona con credenciales válidas de AWS, pueden provocar fugas de datos confidenciales.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket accesible para cualquier usuario autenticado"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-s3api-get-bucket-acl' AND json.rule = 'acl.grants[*].grantee contains AuthenticatedUsers'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'S3'
3. Haga clic en el recurso 'S3' informado en la alerta.
4. Haga clic en 'Permisos'
5. En "Acceso público", haga clic en "Cualquier usuario de AWS" y desmarque todos los elementos.
6. Haga clic en Guardar

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



