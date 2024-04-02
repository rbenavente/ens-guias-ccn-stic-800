resource "prismacloud_policy" "op_exp8_r3" {
   name = "Bucket de AWS S3 CloudTrail para el cual el log de acceso está deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los buckets de S3 CloudTrail para los cuales el log acceso está deshabilitado. El registro de acceso al depósito de S3 genera logs de acceso para cada solicitud realizada a su depósito de S3. Un registro de acceso contiene información como el tipo de solicitud, los recursos especificados en la solicitud trabajados y la hora y fecha en que se procesó la solicitud. Se recomienda habilitar el registro de acceso al depósito en el depósito de CloudTrail S3.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Bucket de AWS S3 CloudTrail para el cual el registro de acceso está deshabilitado"
        criteria = "config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as X; config from cloud.resource where api.name = 'aws-s3api-get-bucket-acl' AND json.rule = loggingConfiguration.targetBucket does not exist as Y; filter '$.X.s3BucketName equals $.Y.bucketName'; show Y; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'S3'.
2. Haga clic en el depósito de S3 que se informó.
3. Haga clic en la pestaña 'Propiedades'.
4. En la sección 'Registro de acceso al servidor', seleccione la opción 'Habilitar' y proporcione el depósito s3 de su elección en el 'Depósito de destino'.
5. Haga clic en 'Guardar cambios'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



