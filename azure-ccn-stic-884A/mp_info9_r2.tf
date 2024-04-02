resource "prismacloud_policy" "mp_info9_r2" {
   name = "Habilitar la copias de seguridad  de My SQL Server con redundancia geográfica"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Asegúrese de que My SQL Server habilite las copias de seguridad con redundancia geográfica
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Habilitar la copias de seguridad  de My SQL Server con redundancia geográfica"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-mysql-server' AND json.rule = properties.storageProfile.geoRedundantBackup does not equal \"Enabled\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guia de configuración https://learn.microsoft.com/en-us/azure/mysql/single-server/concepts-backup
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo9.csrs_id # mp.info9 Compliance Section UUID

   }

}



