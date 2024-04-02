resource "prismacloud_policy" "op_cont4_r1" {
   name = "El endpoint Servicio de AWS Database Migration Service no tiene SSL configurado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los puntos finales del Servicio de migración de bases de datos (DMS) que no están configurados con SSL para cifrar conexiones para los puntos finales de origen y destino. Se recomienda utilizar una conexión SSL para los puntos finales de origen y destino; La aplicación de conexiones SSL ayuda a proteger contra ataques de "hombre en el medio" al cifrar el flujo de datos entre las conexiones de los puntos finales.

NOTA: No todas las bases de datos utilizan SSL de la misma manera. Un punto de enlace de Amazon Redshift ya utiliza una conexión SSL y no requiere una conexión SSL configurada por AWS DMS. Por lo tanto, se incluyen algunas excepciones en la política RQL para informar solo aquellos puntos finales que se pueden configurar utilizando la función DMS SSL.

Para más detalles:
https://docs.aws.amazon.com/dms/latest/userguide/CHAP_Security.html#CHAP_Security.SSL

  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "El endpoint Servicio de AWS Database Migration Service no tiene SSL configurado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-dms-endpoint' AND json.rule = status equals active and (endpointType equals SOURCE and sslMode equals none and engineName is not member of (\"s3\", \"azuredb\")) or (endpointType equals TARGET and sslMode equals none and engineName is not member of (\"dynamodb\", \"kinesis\", \"neptune\", \"redshift\", \"s3\", \"elasticsearch\", \"kafka\"))"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de AWS DMS.
3. En el panel de navegación, elija 'Puntos finales'
4. Seleccione el punto final de DMS informado
5. En "Acciones", elija "Modificar".
6. En la sección 'Configuración del punto final', seleccione el 'modo Secure Socket Layer (SSL)' de la lista desplegable y seleccione el modo SSL adecuado según sus requisitos, excepto 'ninguno'.
7. Haga clic en 'Guardar'

NOTA: Antes de modificar la configuración SSL, debe configurar el certificado adecuado que desea utilizar para la conexión SSL en el servicio 'Certificado' de DMS.


EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opcont4.csrs_id # op.cont4 Compliance Section UUID

   }
   
}



