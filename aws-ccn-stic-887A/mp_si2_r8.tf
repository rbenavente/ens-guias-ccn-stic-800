
resource "prismacloud_policy" "mp_si2_r8" {
   name = "Registro de CloudWatch no cifrados con AWS Key Management Service"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Los datos del grupo de registros siempre se cifran en Registros de CloudWatch. De forma predeterminada, Registros de CloudWatch usa cifrado del lado del servidor para los datos en reposo del registro. Como alternativa, puede utilizar AWS Key Management Service para este cifrado. Si lo hace, el cifrado se realiza con una clave de AWS KMS. El cifrado con AWS KMS se habilita en el nivel del grupo de registro mediante la asociación de una clave de KMS con un grupo de registros, ya sea al crear el grupo de registros o después de crearlo.
Para realizar tareas de monitorización referentes a la detección de actividades relacionadas con el servicio de AWS KMS, recomienda integrar este junto con las funcionalidades de Amazon CloudWatch.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Registro de CloudWatch no cifrados con AWS Key Management Service"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-cloudwatch-log-group' AND json.rule = kmsKeyId does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la siguiente URL:
https://docs.aws.amazon.com/es_es/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html

EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



