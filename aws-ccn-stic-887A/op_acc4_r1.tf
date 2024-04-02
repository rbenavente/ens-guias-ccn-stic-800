resource "prismacloud_policy" "op_acc4_r1" {
   name = "Politica de acceso a la cola  AWS SQS  demasiado permisiva"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica colas de Servicio de cola simple (SQS) que tienen una política de acceso demasiado permisiva. Se recomienda encarecidamente tener la política de acceso con menos privilegios para proteger la cola SQS contra fugas de datos y acceso no autorizado.

Para más detalles:
https://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSDeveloperGuide/sqs-ejemplos-básicos-de-políticas-sqs.html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Politica de acceso a la cola  AWS SQS  demasiado permisiva"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-sqs-get-queue-attributes' AND json.rule = attributes.Policy.Statement[?any(Effect equals Allow and Action anyStartWith sqs: and (Principal.AWS contains * or Principal equals *) and Condition does not exist)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Seleccione la región, en el menú desplegable de regiones, en la que se genera la alerta
3. Vaya al panel del Servicio de cola simple (SQS)
4. Elija el Servicio de cola simple (SQS) informado y elija 'Editar'
5. Desplácese hasta la sección 'Política de acceso'
6. Edite las declaraciones de la política de acceso en el cuadro de entrada. Asegúrese de que 'Principal' no esté configurado en '*', lo que hace que sus colas SQS sean accesibles para cualquier usuario anónimo.\n7. Cuando termine de configurar la política de acceso, elija 'Guardar'.
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # Compliance Section UUID

   }

}



