resource "prismacloud_policy" "mp_info3_r6" {
   name = "Cifrado en tránsito Storage Account"
   policy_type = "config"
   cloud_type = "azure"
   severity = "medium"
   description = <<-EOT
Esta política identifica las cuentas de almacenamiento que tienen la función de transferencia segura deshabilitada. La opción de transferencia segura mejora la seguridad de su cuenta de almacenamiento al permitir únicamente solicitudes a la cuenta de almacenamiento mediante una conexión segura. Cuando se habilita "se requiere transferencia segura", las API REST para acceder a sus cuentas de almacenamiento se conectan mediante HTTP y cualquier solicitud que utilice HTTP será rechazada. Cuando utiliza el servicio de archivos de Azure, la conexión sin cifrado fallará. Se recomienda encarecidamente habilitar la función de transferencia segura en su cuenta de almacenamiento.

NOTA: Azure Storage no admite HTTP para nombres de dominio personalizados; esta opción no se aplica cuando se utiliza un nombre de dominio personalizado.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado en tránsito Storage Account"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-storage-account-list' AND json.rule = properties.supportsHttpsTrafficOnly !exists or properties.supportsHttpsTrafficOnly is false"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar la función de transferencia segura en su cuenta de almacenamiento, siga la siguiente URL:
https://learn.microsoft.com/en-gb/azure/storage/common/storage-require-secure-transfer#require-secure-transfer-for-an-existing-storage-account

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



