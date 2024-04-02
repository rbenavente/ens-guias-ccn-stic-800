resource "prismacloud_policy" "op_mon2_r1" {
   name = "La notificación por correo electrónico de Azure Microsoft Defender for Cloud para el propietario de la suscripción no está configurada"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica Azure Microsoft Defender para la nube (anteriormente conocido como Azure Security Center y Azure Defender) en el que no está configurada la notificación por correo electrónico para los propietarios de suscripciones. Habilitar correos electrónicos de alerta de seguridad para los propietarios de suscripciones garantiza que reciban correos electrónicos de alerta de seguridad de Microsoft. Esto garantiza que estén al tanto de cualquier posible problema de seguridad y puedan mitigar el riesgo de manera oportuna.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "La notificación por correo electrónico de Azure Microsoft Defender for Cloud para el propietario de la suscripción no está configurada"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-security-center-settings' AND json.rule = (securityContacts is empty or securityContacts[*].properties.email is empty or securityContacts[*].properties.alertsToAdmins equal ignore case Off) and pricings[?any(properties.pricingTier equal ignore case Standard)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en el portal de Azure.
2. Vaya a 'Microsoft Defender para la nube'
3. Seleccione 'Configuración del entorno'
4. Haga clic en el nombre de la suscripción.
5. Haga clic en 'Notificaciones por correo electrónico'
6. En el menú desplegable del campo "Todos los usuarios con los siguientes roles", seleccione "Propietario".
7. Seleccione 'Guardar'
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opmon2.csrs_id # op.mon2 Compliance Section UUID

   }

}



