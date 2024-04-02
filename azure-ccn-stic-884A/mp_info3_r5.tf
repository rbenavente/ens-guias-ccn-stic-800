resource "prismacloud_policy" "mp_info3_r5" {
   name = "Deshabilitar trafico no cifrado en App Service"
   policy_type = "config"
   cloud_type = "azure"
   severity = "medium"
   description = <<-EOT
Azure Web Apps permite que los sitios se ejecuten bajo HTTP y HTTPS de forma predeterminada. Cualquiera puede acceder a las aplicaciones web mediante enlaces HTTP no seguros de forma predeterminada. Las solicitudes HTTP no seguras se pueden restringir y todas las solicitudes HTTP se pueden redirigir al puerto HTTPS seguro. Se recomienda imponer el tráfico solo HTTPS.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Deshabilitar trafico no cifrado en App Service"
        criteria = "config from cloud.resource where api.name = 'azure-app-service' AND json.rule = properties.httpsOnly is false"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en el portal de Azure.
2. Navegue a Servicios de aplicaciones
3. Haga clic en la aplicación informada.
4. En la sección Configuración, haga clic en 'Configuración'
5. En "Configuración general", en "Configuración de plataforma", establezca "Solo HTTPS" en "Activado".

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpinfo3.csrs_id # mp.info3 Compliance Section UUID

   }

}



