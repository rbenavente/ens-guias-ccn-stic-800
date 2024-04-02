resource "prismacloud_policy" "mp_info3_r1" {
   name = "Cifrado en reposo SQL Server"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
La información con un nivel alto en confidencialidad debe ser cifrada, tanto en reposo como durante su transmisión.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado en reposo SQL Server"
        criteria = "config from cloud.resource where api.name = 'azure-sql-server-list' AND json.rule = (sqlEncryptionProtectors[*] does not exist or sqlEncryptionProtectors[*].kind does not equal \"azurekeyvault\")"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guia de configuración para activar el cifrado en reposo: https://learn.microsoft.com/es-es/sql/relational-databases/security/encryption/sql-server-encryption?view=sql-server-ver16
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



