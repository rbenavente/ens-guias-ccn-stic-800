
resource "prismacloud_policy" "op_exp10_r7" {
   name = "Retención del registro de actividad: la retención que se recomienda seleccionar es de 365 días"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
El registro de actividad de Azure proporciona información de los eventos de nivel de suscripción que se han producido en Azure. Esta incluye una serie de datos, desde datos operativos de Azure Resource Manager hasta actualizaciones en eventos de Estado del servicio.
Es importante ya que ante un incidente de seguridad que requiera de forense son necesarios los logs de auditoría.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Retención de los logs de auditoría de las tablas de datos SQL han de ser igual o superior a 365 días"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND cloud.service = 'Azure Monitor' AND api.name = 'azure-monitor-log-profiles-list' AND json.rule = 'isLegacy is true and (properties.retentionPolicy !exists or (properties.retentionPolicy.days != 0 and properties.retentionPolicy.days < 365))'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para la protección y retención del registro de actividad se deben realizar las siguientes acciones:
- Creación de un Área de trabajo en Log Analytics
- Despliegue Área de trabajo de Log Analytics
- Creación de una cuenta de almacenamiento
Consulte guia CCN STIC 884A Guía de configuración segura para Azure para mas infomración.
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

   }

}



