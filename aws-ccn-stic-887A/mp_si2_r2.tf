
resource "prismacloud_policy" "mp_si2_r2" {
   name = "La cola AWS SQS no está configurada con cifrado del lado del servidor"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las colas de AWS SQS que no están configuradas con cifrado del lado del servidor. Habilitar el cifrado del lado del servidor cifraría todos los mensajes que se envían a la cola y los mensajes se almacenarán de forma cifrada. Amazon SQS descifra un mensaje solo cuando se envía a un consumidor autorizado. Se recomienda habilitar el cifrado del lado del servidor para las colas de AWS SQS para proteger los datos confidenciales en caso de una violación de datos o de que usuarios malintencionados obtengan acceso a los datos.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "La cola AWS SQS no está configurada con cifrado del lado del servidor"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-sqs-get-queue-attributes' AND json.rule = attributes.KmsMasterKeyId does not exist and attributes.SqsManagedSseEnabled is false"
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



