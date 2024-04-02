resource "prismacloud_policy" "mp_info9_r1" {
   name = "Habilitar la copias de seguridad  de PostgreSQL Server con redundancia geográfica"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Habilitar la copias de seguridad  de PostgreSQL Server con redundancia geográfica
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Habilitar la copias de seguridad  de PostgreSQL Server con redundancia geográfica"
        criteria = "config from cloud.resource where api.name = 'azure-postgresql-server' AND json.rule = properties.storageProfile.geoRedundantBackup does not equal \"Enabled\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guia de configuración https://learn.microsoft.com/en-us/azure/postgresql/flexible-server/concepts-backup-restore
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo9.csrs_id # mp.info9 Compliance Section UUID

   }

}



