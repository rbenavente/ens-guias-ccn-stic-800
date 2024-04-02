resource "prismacloud_policy" "mp_com3_r1" {
   name = "Red virtual de Azure no protegida por el estándar de protección DDoS"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica redes virtuales no protegidas por el estándar de protección DDoS. Los ataques de denegación de servicio distribuido (DDoS) son algunos de los mayores problemas de disponibilidad y seguridad que agotan los recursos de una aplicación, haciendo que la aplicación no esté disponible para usuarios legítimos. Azure DDoS Protection Standard proporciona características mejoradas de mitigación de DDoS para defenderse de los ataques DDoS.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Red virtual de Azure no protegida por el estándar de protección DDoS"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-network-vnet-list' AND json.rule = ['properties.provisioningState'] equals Succeeded and (['properties.ddosProtectionPlan'].['id'] does not exist or ['properties.enableDdosProtection'] is false)"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en el Portal de Azure
2. Vaya al panel de redes virtuales
3. Haga clic en la red virtual informada.
4. En 'Configuración', haga clic en 'Protección DDoS'
NOTA: Antes de habilitar la protección DDoS, si ya no existe un plan de protección DDoS, debe configurar un plan de protección DDoS para su organización siguiendo las instrucciones de URL a continuación:
https://docs.microsoft.com/en-us/azure/ddos-protection/manage-ddos-protection#create-a-ddos-protection-plan
5. Seleccione 'Activar' para 'Estándar de protección DDoS' y elija 'Plan de protección DDoS' en el menú desplegable o ingrese el ID de recurso del plan de protección DDoS.
6. Haga clic en 'Guardar'
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mps8.csrs_id # mp.s8 Compliance Section UUID

   }

}



