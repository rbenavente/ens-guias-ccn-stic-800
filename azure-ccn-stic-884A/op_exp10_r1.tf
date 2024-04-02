resource "prismacloud_policy" "op_exp10_r1" {
   name = "Cifrado del almacenamiento donde se encuentran todos los registros de actividad."
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Esta política identifica las cuentas de almacenamiento que contienen los  registros de actividad y  tiene el cifrado BYOK deshabilitado. La cuenta de almacenamiento de Azure con los registros de actividad  debe usar BYOK (usar su propia clave) para el cifrado, lo que proporciona controles de confidencialidad adicionales en los datos de registro.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Cifrado del almacenamiento donde se encuentran todos los registros de actividad."
        criteria = "config from cloud.resource where api.name = 'azure-storage-account-list' as X; config from cloud.resource where api.name = 'azure-monitor-log-profiles-list' as Y; filter '($.X.properties.encryption.keySource does not equal \"Microsoft.\" and $.X.properties.encryption.keyvaultproperties.keyname is not empty and $.X.properties.encryption.keyvaultproperties.keyversion is not empty and $.X.properties.encryption.keyvaultproperties.keyvaulturi is not empty and $.Y.properties.storageAccountId contains $.X.name)'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en el Portal de Azure
2. Vaya al panel de cuentas de almacenamiento y haga clic en cuenta de almacenamiento informada.
3. En el menú Configuración, haga clic en Cifrado.
4. Seleccione Claves administradas por el cliente
- Elija 'Ingresar URI de clave' e ingrese 'URI de clave'
O
- Elija 'Seleccionar desde Key Vault', ingrese 'Key Vault' y 'Clave de cifrado'
5. Haga clic en 'Guardar'
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

   }

}



