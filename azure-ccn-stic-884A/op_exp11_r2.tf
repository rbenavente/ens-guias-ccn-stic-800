resource "prismacloud_policy" "op_exp11_r2" {
   name = "El registro de auditoría de Azure Key Vault está deshabilitado"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Esta política identifica las instancias de Azure Key Vault para las que el registro de auditoría está deshabilitado. Como práctica recomendada, habilite el registro de eventos de auditoría para instancias de Key Vault para supervisar cómo y cuándo se accede a sus almacenes de claves, y quién lo hace.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "El registro de auditoría de Azure Key Vault está deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-key-vault-list' AND json.rule = \"not ( diagnosticSettings.value[*].properties.logs[*].enabled any equal true and diagnosticSettings.value[*].properties.logs[*].enabled size greater than 0 )\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en el portal de Azure
2. Seleccione 'Almacén de claves'
3. Seleccione la instancia del almacén de claves para modificar.
4. Seleccione 'Configuración de diagnóstico' en 'Monitoreo'
5. Haga clic en '+Agregar configuración de diagnóstico'
6. Especifique un 'Nombre de configuración de diagnóstico',
7. En la sección "Detalles de la categoría", en Registro, seleccione "Evento de auditoría".
8. En la sección 'Detalles del destino',
a. Si selecciona "Enviar al espacio de trabajo de Log Analytics", configure la "Suscripción" y el "espacio de trabajo de Log Analytics".
b. Si selecciona 'Archivar en cuenta de almacenamiento', configure 'Suscripción', 'Cuenta de almacenamiento' y 'Retención (días)'
C. Si selecciona "Transmitir a un centro de eventos", establezca la "Suscripción", el "Espacio de nombres del centro de eventos", el "Nombre del centro de eventos" y el "Nombre de la política del centro de eventos".
d. Si selecciona "Enviar a solución de socio", configure la "Suscripción" y el "Destino".
9. Haga clic en 'Guardar'
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp11.csrs_id # op.exp11 Compliance Section UUID

   }

}



