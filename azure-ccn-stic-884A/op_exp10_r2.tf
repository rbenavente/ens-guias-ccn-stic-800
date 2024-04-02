resource "prismacloud_policy" "op_exp10_r2" {
   name = "Habilitar el audit log para los datos de los server SQL."
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Las auditorías de los datos de los server SQL han de estar activas, permitiendo tener el histórico de modificaciones sobre el server SQL. Esto es obligatorio por normativa. Cabe tener en cuenta que, si activamos la auditoría en el server, ésta también se aplica en cada una de las bases de datos adjuntas a éste, por tanto no hace falta activar también la auditoría en cada una de las bases de datos  
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Habilitar el audit log para los datos de los server SQL"
        criteria = "config from cloud.resource where api.name = 'azure-sql-server-list' and json.rule = serverBlobAuditingPolicy.properties.state equals \"Disabled\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guia de configuración  https://learn.microsoft.com/es-es/azure/azure-sql/database/auditing-setup?view=azuresql
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

   }

}



