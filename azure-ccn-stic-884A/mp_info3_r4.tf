resource "prismacloud_policy" "mp_info3_r4" {
   name = "Cifrado en tránsito PostgreSQL"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica los servidores de bases de datos PostgreSQL para los cuales el estado de aplicación de SSL está deshabilitado. La conectividad SSL ayuda a proporcionar una nueva capa de seguridad, al conectar el servidor de la base de datos a las aplicaciones cliente mediante Secure Sockets Layer (SSL). Hacer cumplir las conexiones SSL entre el servidor de la base de datos y las aplicaciones cliente ayuda a proteger contra ataques "intermediarios" al cifrar el flujo de datos entre el servidor y la aplicación.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado en tránsito PostgreSQL"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-postgresql-server' AND json.rule = properties.sslEnforcement does not equal \"Enabled\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de Azure
2. Navegue hasta el panel 'Azure Database para servidores PostgreSQL'.
3. Haga clic en el nombre de la base de datos alertada.
4. Vaya a 'Seguridad de la conexión' en el bloque 'Configuración'.
5. En el bloque 'Configuración SSL', para el campo 'Aplicar conexión SSL', haga clic en 'Activado' en el botón de alternancia.
6. Haga clic en el botón 'Guardar' del menú superior para guardar el cambio.

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



