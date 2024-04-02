resource "prismacloud_policy" "mp_info3_r9" {
   name = "Azure Cache para Redis no está configurado con cifrado de datos en tránsito"
   policy_type = "config"
   cloud_type = "azure"
   severity = "medium"
   description = <<-EOT
Esta política identifica Azure Cache for Redis que no están configurados con cifrado de datos en tránsito. Hacer cumplir una conexión SSL ayuda a evitar que usuarios no autorizados lean datos confidenciales que se interceptan mientras viajan a través de la red, entre clientes/aplicaciones y servidores de caché, conocidos como datos en tránsito. Se recomienda configurar el cifrado en tránsito para Azure Cache for Redis.
Consulte el siguiente enlace para obtener más detalles:
https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#access-ports

 EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Azure Cache para Redis no está configurado con cifrado de datos en tránsito"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-cache-redis' AND json.rule = properties.provisioningState equal ignore case Succeeded and properties.enableNonSslPort is true"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar datos en tránsito para su Azure Cache for Redis existente, siga la siguiente URL:
https://learn.microsoft.com/en-us/azure/azure-cache-for-redis/cache-configure#access-ports
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



