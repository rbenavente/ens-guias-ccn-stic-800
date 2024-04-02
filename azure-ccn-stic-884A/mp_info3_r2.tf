resource "prismacloud_policy" "mp_info3_r2" {
   name = "Cifrado de disco en VM"
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
        name = "Cifrado de disco en VM"
        criteria = "config from cloud.resource where api.name = 'azure-disk-list' AND json.rule = (tags.Vendor does not equal \"Databricks\") and ( encryption.type exists and encryption.type does not contain \"Encryption\" ) or encryption.type does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guia de configuración para activar el cifrado en reposo: 
https://learn.microsoft.com/es-es/azure/virtual-machines/windows/disk-encryption-overview
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



