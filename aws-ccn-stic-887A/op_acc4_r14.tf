resource "prismacloud_policy" "op_acc4_r14" {
   name = "URL de  función AWS Lambda con permisos demasiado permisivos para el uso compartido de recursos entre orígenes (CORS)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica las funciones de AWS Lambda que tienen permisos de uso compartido de recursos entre orígenes (CORS) demasiado permisivos. Las configuraciones CORS demasiado permisivas (que permiten comodines) pueden exponer potencialmente la función Lambda a solicitudes injustificadas y ataques de secuencias de comandos entre sitios. Se recomienda encarecidamente especificar los dominios exactos (en 'allowOrigins') y los métodos HTTP (en 'allowMethods') a los que se les debe permitir interactuar con su función para garantizar una configuración segura.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
       name = "URL de  función AWS Lambda con permisos demasiado permisivos para el uso compartido de recursos entre orígenes (CORS)"
       criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-lambda-list-functions' AND json.rule = cors exists and cors.allowOrigins[*] contains \"*\" and cors.allowMethods[*] contains \"*\""
       parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar correctamente los permisos CORS, consulte la siguiente URL:
https://docs.aws.amazon.com/lambda/latest/dg/API_Cors.html   

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



