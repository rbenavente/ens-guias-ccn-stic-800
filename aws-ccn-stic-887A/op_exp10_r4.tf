
resource "prismacloud_policy" "op_exp10_r4" {
   name = "Cola AWS SQS utilizando la clave KMS predeterminada en lugar de CMK" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica colas SQS que están cifradas con claves KMS predeterminadas y no con claves maestras de cliente (CMK). Se recomienda utilizar claves maestras administradas por el cliente para cifrar los mensajes de la cola SQS. Le brinda control total sobre los datos de los mensajes cifrados.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Cola AWS SQS utilizando la clave KMS predeterminada en lugar de CMK"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-sqs-get-queue-attributes' AND json.rule = 'attributes.KmsMasterKeyId exists and attributes.KmsMasterKeyId contains alias/aws/sqs' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Seleccione la región, en el menú desplegable de regiones, en la que se genera la alerta.
3. Navegue hasta el panel de Servicio de cola simple (SQS).
4. Elija el Servicio de cola simple (SQS) informado
5. Haga clic en 'Acciones de cola' y elija 'Configurar cola' en el menú desplegable.
6. En la ventana emergente 'Configurar', en la sección 'Configuración de cifrado del lado del servidor (SSE)'; Elija una 'Clave maestra de cliente (CMK) de AWS KMS' de la lista desplegable o copie el ARN de la clave existente en lugar de la clave alias/aws/sqs (predeterminada).
7. Haga clic en 'Guardar cambios'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



