resource "prismacloud_policy" "op_exp11_r3" {
   name = "Acceso Internet Key Vault [Datos no sensibles]]: Acceso permitido al Key Vault desde Internet sin restricciones de red"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Azure Key Vault protege las claves criptográficas, los certificados (y las claves privadas asociadas a estos) y los secretos (como cadenas de conexión y contraseñas) en la nube. No obstante, cuando almacena datos confidenciales y críticos para la empresa, debe tomar medidas para maximizar la seguridad de los almacenes y de los datos almacenados en estos.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Acceso Internet Key Vault [Datos no sensibles]]: Acceso permitido al Key Vault desde Internet sin restricciones de red"
        criteria = "config from cloud.resource where api.name = 'azure-key-vault-list' and json.rule = (tags.dataclassification equals internal or tags.dataclassification equals departamental) and ( properties.networkAcls does not exist or properties.networkAcls.defaultAction equals \"Allow\" )"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte: https://learn.microsoft.com/es-es/azure/key-vault/general/security-features#access-model-overview
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp11.csrs_id # op.exp11 Compliance Section UUID

   }

}



