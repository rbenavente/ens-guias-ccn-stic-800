
resource "prismacloud_policy" "mp_si2_r3" {
   name = "Instancia de AWS RDS no cifrada"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica instancias de AWS RDS que no están cifradas. Amazon Relational Database Service (Amazon RDS) es un servicio web que facilita la configuración y administración de bases de datos. Amazon permite a los clientes activar el cifrado para RDS, lo cual se recomienda por razones de cumplimiento y seguridad.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia de AWS RDS no cifrada"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name='aws-rds-describe-db-instances' AND json.rule= 'engine is not member of (\"sqlserver-ex\") and  dbinstanceStatus equals available and dbiResourceId does not equal null' as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '$.X.storageEncrypted does not exist or $.X.storageEncrypted is false or ($.X.storageEncrypted is true and $.X.kmsKeyId exists and $.Y.keyMetadata.keyState equals Disabled and $.X.kmsKeyId equals $.Y.keyMetadata.arn)'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar el cifrado del lado del servidor para la cola AWS SQS, siga la siguiente URL según sea necesario:

Para configurar la clave de Amazon SQS (SSE-SQS) para una cola:
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sqs-sse-queue.html

Para configurar la clave de AWS Key Management Service (SSE-KMS) para una cola:
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-configure-sse-existing-queue.html

EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



