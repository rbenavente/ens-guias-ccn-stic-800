resource "prismacloud_policy" "op_exp11_r5" {
   name = "Azure Key Vault no es recuperable"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
El almacén de claves contiene claves de objetos, secretos y certificados. La falta de disponibilidad accidental de un almacén de claves puede provocar la pérdida inmediata de datos o la pérdida de funciones de seguridad (autenticación, validación, verificación, no repudio, etc.) admitidas por los objetos del almacén de claves.
Se recomienda que el almacén de claves sea recuperable habilitando las funciones "No purgar" y "Eliminación temporal". Esto es para evitar la pérdida de datos cifrados, incluidas las cuentas de almacenamiento, las bases de datos SQL y/o los servicios dependientes proporcionados por los objetos del almacén de claves (claves, secretos, certificados), etc., como puede ocurrir en el caso de una eliminación accidental por parte de un usuario o de la actividad disruptiva de un usuario malicioso.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Azure Key Vault no es recuperable"
        criteria = "config from cloud.resource where api.name = 'azure-key-vault-list' AND json.rule = 'properties.enableSoftDelete does not exist or properties.enablePurgeProtection does not exist'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Portal Azul
Azure Portal no tiene provisiones para actualizar las configuraciones respectivas

CLI de Azure 2.0
actualización de recursos az --id /subscriptions/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/<resourceGroupName>/providers/Microsoft.KeyVault/vaults/<keyVaultName> --set properties.enablePurgeProtection=true properties.enableSoftDelete=true

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp11.csrs_id # op.exp11 Compliance Section UUID

   }

}



