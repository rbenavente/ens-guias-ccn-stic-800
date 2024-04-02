resource "prismacloud_policy" "op_acc2_r5" {
   name = "JIT Supervisión del acceso a la red Azure Microsoft Defender for Cloud deshabilitada"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica las políticas de Azure Microsoft Defender para la nube (anteriormente conocidas como Azure Security Center y Azure Defender) que tienen la supervisión de acceso a la red JIT configurada como deshabilitada. Habilitar el acceso a la red JIT mejorará la protección de las máquinas virtuales mediante la creación de una máquina virtual justo a tiempo. La regla JIT VM con NSG restringirá la disponibilidad de acceso a los puertos para conectarse a la VM durante un tiempo preestablecido y solo después de verificar los permisos de control de acceso basado en roles del usuario. Esta característica controlará los ataques de fuerza bruta a las máquinas virtuales.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "JIT Supervisión del acceso a la red Azure Microsoft Defender for Cloud deshabilitada"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-policy-assignments' AND json.rule = '((name == SecurityCenterBuiltIn and properties.parameters.jitNetworkAccessMonitoringEffect.value equals Disabled) or (name == SecurityCenterBuiltIn and properties.parameters[*] is empty and properties.displayName does not start with \"ASC Default\"))'"
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
4. Elija la suscripción reportada
5. Haga clic en 'Política de seguridad' en la sección 'Configuración de política'.
6. Haga clic en 'SecurityCenterBuiltIn'
7. Seleccione la pestaña 'Parámetros'
8. Establezca "Los puertos de administración de las máquinas virtuales deben protegerse con control de acceso a la red justo a tiempo" en "AuditIfNotExists".
9. Si no se requieren otros cambios, haga clic en 'Revisar + guardar'
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc2.csrs_id # op.acc2 Compliance Section UUID

   }

}



