
resource "prismacloud_policy" "op_exp10_r5" {
   name = "Habilitar el audit log para los datos en el server al que pertenecen la base de datos SQL, o en su defecto, habilitarlo en la base de datos"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
El registro de actividad de Azure proporciona información de los eventos de nivel de suscripción que se han producido en Azure. Esta incluye una serie de datos, desde datos operativos de Azure Resource Manager hasta actualizaciones en eventos de Estado del servicio
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Habilitar el audit log para los datos en el server al que pertenecen la base de datos SQL, o en su defecto, habilitarlo en la base de datos"
        criteria = "config from cloud.resource where api.name = 'azure-sql-db-list' AND json.rule = blobAuditPolicy.properties.state equals \"Disabled\""
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



