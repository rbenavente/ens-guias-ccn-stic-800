resource "prismacloud_policy" "op_exp8_r6" {
   name = "Filtro de métricas y alarmas de AWS Log no existe para los fallos de autenticación en la consola de gestión"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las cuentas de AWS que no tienen un filtro de métricas de registro ni una alarma para errores de autenticación de la consola de administración de AWS. La supervisión de los inicios de sesión fallidos en la consola puede reducir el tiempo de espera para detectar un intento de fuerza bruta en una credencial, lo que puede proporcionar un indicador, como la IP de origen, que se puede utilizar en otra correlación de eventos. Se recomienda establecer un filtro de métricas y una alarma para los intentos fallidos de autenticación de la consola.

NOTA: Esta política activará una alerta si tiene al menos un Cloudtrail con la prueba múltiple habilitada, registra todos los eventos de administración y no está configurado con un filtro de métrica de registro y alarma específicos en su cuent
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Filtro de métricas y alarmas de AWS Log no existe para los fallos de autenticación en la consola de gestión"
        criteria = "config from cloud.resource where api.name = 'aws-logs-describe-metric-filters' as X; config from cloud.resource where api.name = 'aws-cloudwatch-describe-alarms' as Y; config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as Z; filter '(($.Z.cloudWatchLogsLogGroupArn is not empty and $.Z.cloudWatchLogsLogGroupArn contains $.X.logGroupName and $.Z.isMultiRegionTrail is true and $.Z.includeGlobalServiceEvents is true) and (($.X.filterPattern contains \"eventName=\" or $.X.filterPattern contains \"eventName =\") and ($.X.filterPattern does not contain \"eventName!=\" and $.X.filterPattern does not contain \"eventName !=\") and $.X.filterPattern contains ConsoleLogin and ($.X.filterPattern contains \"errorMessage=\" or $.X.filterPattern contains \"errorMessage =\") and ($.X.filterPattern does not contain \"errorMessage!=\" and $.X.filterPattern does not contain \"errorMessage !=\") and $.X.filterPattern contains \"Failed authentication\") and ($.X.metricTransformations[*] contains $.Y.metricName))'; show X; count(X) less than 1"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
   
1. Inicie sesión en la consola de AWS
2. Navegue al panel de CloudWatch
3. Haga clic en 'Grupos de registros' en la sección 'Registros' (panel izquierdo)
4. Seleccione el grupo de registros creado para sus registros de eventos de seguimiento de CloudTrail (Cloudtrail debe estar habilitado para múltiples seguimientos con todos los eventos de gestión capturados) y haga clic en el botón "Crear filtro de métricas".
5. En la página 'Definir filtro de métricas de registros', agregue el valor 'Patrón de filtro' como
{ ($.eventName = ConsoleLogin) && ($.errorMessage = "Autenticación fallida") }
y haga clic en 'Asignar métrica'
6. En la página "Crear filtro de métrica y asignar una métrica", elija Nombre del filtro, parámetro Detalles de métrica según sus requisitos y haga clic en "Crear filtro".
7. Haga clic en 'Crear alarma',
- En el Paso 1, especifique los detalles de las métricas y las condiciones según sea necesario y haga clic en "Siguiente".
- En el paso 2, seleccione un tema de SNS, ya sea creando un tema nuevo o utilizando un tema de SNS/ARN existente y haga clic en "Siguiente".
- En el Paso 3, seleccione el nombre y la descripción de la alarma y haga clic en "Siguiente".
- En el Paso 4, obtenga una vista previa de los datos ingresados y haga clic en 'Crear alarma'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



