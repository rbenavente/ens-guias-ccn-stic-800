resource "prismacloud_policy" "op_mon3_r6" {
   name = "Dominio AWS Elasticsearch con registros lentos de búsqueda deshabilitados"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los dominios de Elasticsearch para los cuales los registros lentos de búsqueda están deshabilitados en su cuenta de AWS. Habilitar la compatibilidad con la publicación de registros lentos de búsqueda en AWS CloudWatch Logs le permite tener información completa sobre el rendimiento de las operaciones de búsqueda realizadas en sus clústeres de Elasticsearch. Esto le ayudará a identificar problemas de rendimiento causados por consultas de búsqueda específicas para que pueda optimizar sus consultas para solucionar el problema.

  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Dominio AWS Elasticsearch con registros lentos de búsqueda deshabilitados"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-es-describe-elasticsearch-domain' AND json.rule = 'processing is false and (logPublishingOptions does not exist or logPublishingOptions.SEARCH_SLOW_LOGS.enabled is false or logPublishingOptions.SEARCH_SLOW_LOGS.cloudWatchLogsLogGroupArn is empty)'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el panel del servicio Elasticsearch.
4. Elija el dominio de Elasticsearch informado
5. Seleccione la pestaña 'Registros'
6. En la sección 'Configurar búsqueda de registros lentos',
a. haga clic en 'Configurar'
b. En la configuración 'Seleccionar grupo de registros de CloudWatch Logs', cree/use el grupo de registros de CloudWatch Logs existente según sus requisitos.
C. En 'Especificar la política de acceso a CloudWatch', cree una nueva/seleccione una política existente según sus requisitos.
d. Haga clic en 'Habilitar'

La configuración de "Estado" de búsqueda de registros lentos debería cambiar ahora a "Habilitado".
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id  # op.mon3 Compliance Section UUID

  }
 
   
}



