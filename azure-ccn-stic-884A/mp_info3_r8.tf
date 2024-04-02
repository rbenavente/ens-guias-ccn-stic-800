resource "prismacloud_policy" "mp_info3_r8" {
   name = "Cifrado en tránsito MariaDB"
   policy_type = "config"
   cloud_type = "azure"
   severity = "medium"
   description = <<-EOT
Esta política identifica los servidores de bases de datos MariaDB para los cuales el estado de aplicación de SSL está deshabilitado. Azure Database para MariaDB admite la conexión del servidor de Azure Database para MariaDB a aplicaciones cliente mediante Secure Sockets Layer (SSL). Aplicar conexiones SSL entre su servidor de base de datos y sus aplicaciones cliente ayuda a protegerse contra ataques de "intermediarios" al cifrar el flujo de datos entre el servidor y su aplicación. Se recomienda aplicar SSL para acceder a su servidor de base de datos.
 EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado en tránsito MariaDB"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-database-maria-db-server' AND json.rule = properties.userVisibleState equals Ready and properties.sslEnforcement equals Disabled"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar la conexión SSL en una base de datos de Azure existente para MariaDB, siga la siguiente URL:
https://docs.microsoft.com/en-us/azure/mariadb/howto-configure-ssl

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



