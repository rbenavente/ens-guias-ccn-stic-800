resource "prismacloud_policy" "mp_info3_r3" {
   name = "Cifrado en tránsito MySQL"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica los servidores flexibles de bases de datos Azure MySQL para los cuales la aplicación de SSL está deshabilitada. La conectividad SSL ayuda a proporcionar una nueva capa de seguridad, al conectar el servidor de la base de datos a las aplicaciones cliente mediante Secure Sockets Layer (SSL). Hacer cumplir las conexiones SSL entre el servidor de la base de datos y las aplicaciones cliente ayuda a proteger contra ataques de "intermediario" al cifrar el flujo de datos entre el servidor y la aplicación.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado en tránsito MySQL"
        criteria = "config from cloud.resource where api.name = 'azure-mysql-server' AND json.rule = 'properties.sslEnforcement does not equal Enabled'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar la conexión SSL del servidor flexible de la base de datos MySQL, consulte la siguiente URL:
https://docs.microsoft.com/en-us/azure/mysql/flexible-server/how-to-connect-tls-ssl
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



