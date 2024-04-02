resource "prismacloud_policy" "op_exp8_r5" {
   name = "Filtro de métricas y alarmas de AWS Log no existen para los cambios de políitcas de IAM"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las regiones de AWS que no tienen un filtro de métricas de registro ni una alarma para cambios en la política de IAM. Monitorear los cambios en las políticas de IAM ayudará a garantizar que los controles de autenticación y autorización permanezcan intactos. Se recomienda establecer un filtro de métricas y cambios de alarma realizados en las políticas de administración de identidad y acceso (IAM).

NOTA: Esta política activará una alerta si tiene al menos un Cloudtrail con la prueba múltiple habilitada, registra todos los eventos de administración en su cuenta y no está configurado con un filtro de métrica de registro y alarma específicos.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Filtro de métricas y alarmas de AWS Log no existen para los cambios de políitcas de IAM"
        criteria = "config from cloud.resource where api.name = 'aws-logs-describe-metric-filters' as X; config from cloud.resource where api.name = 'aws-cloudwatch-describe-alarms' as Y; config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as Z; filter '(($.Z.cloudWatchLogsLogGroupArn is not empty and $.Z.cloudWatchLogsLogGroupArn contains $.X.logGroupName and $.Z.isMultiRegionTrail is true and $.Z.includeGlobalServiceEvents is true) and (($.X.filterPattern contains \"eventName=\" or $.X.filterPattern contains \"eventName =\") and ($.X.filterPattern does not contain \"eventName!=\" and $.X.filterPattern does not contain \"eventName !=\") and $.X.filterPattern contains DeleteGroupPolicy and $.X.filterPattern contains DeleteRolePolicy and $.X.filterPattern contains DeleteUserPolicy and $.X.filterPattern contains PutGroupPolicy and $.X.filterPattern contains PutRolePolicy and $.X.filterPattern contains PutUserPolicy and $.X.filterPattern contains CreatePolicy and $.X.filterPattern contains DeletePolicy and $.X.filterPattern contains CreatePolicyVersion and $.X.filterPattern contains DeletePolicyVersion and $.X.filterPattern contains AttachRolePolicy and $.X.filterPattern contains DetachRolePolicy and $.X.filterPattern contains AttachUserPolicy and $.X.filterPattern contains DetachUserPolicy and $.X.filterPattern contains AttachGroupPolicy and $.X.filterPattern contains DetachGroupPolicy) and ($.X.metricTransformations[*] contains $.Y.metricName))'; show X; count(X) less than 1"
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
4. Seleccione el grupo de registros creado para sus registros de eventos de seguimiento de CloudTrail (CloudTrail debe estar habilitado para múltiples seguimientos con todos los eventos de administración capturados) y haga clic en el botón "Crear filtro de métricas".
5. En la página 'Definir filtro de métricas de registros', agregue el valor 'Patrón de filtro' como
{ ($.eventName=DeleteGroupPolicy)||($.eventName=DeleteRolePolicy)||($.eventName=DeleteUserPolicy)||($.eventName=PutGroupPolicy)||($.eventName=PutRolePolicy)||($.eventName =PutUserPolicy)||($.eventName=CreatePolicy)||($.eventName=DeletePolicy)||($.eventName=CreatePolicyVersion)||($.eventName=DeletePolicyVersion)||($.eventName=AttachRolePolicy)|| ($.eventName=DetachRolePolicy)||($.eventName=AttachUserPolicy)||($.eventName=DetachUserPolicy)||($.eventName=AttachGroupPolicy)||($.eventName=DetachGroupPolicy) }
y haga clic en 'Asignar métrica'
6. En la página "Crear filtro de métrica y asignar una métrica", elija Nombre del filtro, parámetro Detalles de métrica según sus requisitos y haga clic en "Crear filtro".
7. Haga clic en 'Crear alarma',
- En el Paso 1, especifique los detalles de las métricas y las condiciones según sea necesario y haga clic en "Siguiente".
- En el paso 2, seleccione un tema de SNS, ya sea creando un tema nuevo o utilizando un tema de SNS/ARN existente y haga clic en "Siguiente".
- En el Paso 3, seleccione el nombre y la descripción de la alarma y haga clic en "Siguiente".
- En el Paso 4, obtenga una vista previa de los datos ingresados y haga clic en 'Crear alarma'.
​
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



