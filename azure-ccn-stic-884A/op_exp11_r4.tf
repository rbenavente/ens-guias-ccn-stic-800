resource "prismacloud_policy" "op_exp11_r4" {
   name = "Deberá utilizarse Key Vault para generar las claves del cifrado de los Azure Storage"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Esta política identifica la cuenta de almacenamiento de Azure que tiene el cifrado con claves administradas por el cliente deshabilitado. De forma predeterminada, todos los datos en reposo en la cuenta de Azure Storage se cifran mediante claves administradas de Microsoft. Se recomienda usar claves administradas por el cliente para cifrar datos en cuentas de almacenamiento de Azure para un mejor control de los datos de la cuenta de almacenamiento.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Deberá utilizarse Key Vault para generar las claves del cifrado de los Azure Storage"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-storage-account-list' AND json.rule = properties.encryption.keySource equals \"Microsoft.Storage\""
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
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp11.csrs_id # op.exp11 Compliance Section UUID

   }

}



