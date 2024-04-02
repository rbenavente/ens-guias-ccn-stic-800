resource "prismacloud_policy" "mp_info2_r2" {
   name = "Etiquetado Storage Account (costcenter) ** Cambiar etiqueta"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Las etiquetas de los recursos Azure están estrechamente vinculadas con los estándares de nomenclatura y clasificación de los recursos. A medida que se agregan recursos a las suscripciones, cada vez resulta más importante clasificar los de forma lógica para fines de facturación, administración y operativos.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Etiquetado Storage Account (costcenter)"
        criteria = "config from cloud.resource where api.name = 'azure-storage-account-list' AND json.rule = tags.costcenter does not exist or tags.costcenter is empty"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Modifique la configuración del recurso para añadir la etiqueta comrrespondiente
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo2.csrs_id # mp.info2 Compliance Section UUID

   }

}



