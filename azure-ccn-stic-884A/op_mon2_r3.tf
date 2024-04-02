resource "prismacloud_policy" "op_mon2_r3" {
   name = "Los registros de flujo del grupo de seguridad de red (NSG) de Azure Network Watcher están deshabilitados"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica los grupos de seguridad de red (NSG) de Azure para los que los registros de flujo están deshabilitados. Para realizar esta comprobación, habilite esta acción en la entidad de servicio de Azure: 'Microsoft.Network/networkWatchers/queryFlowLogStatus/action'.

Los registros de flujo de NSG, una función de la aplicación Network Watcher, le permiten ver información sobre el tráfico IP de entrada y salida a través de un NSG. Los registros de flujo incluyen información como:
- Flujos entrantes y salientes por regla.
- Interfaz de red a la que se aplica el flujo.
- Información de 5 tuplas sobre el flujo (IP de origen/destino, puerto de origen/destino, protocolo).
- Si el tráfico fue permitido o denegado.

Como práctica recomendada, habilite los registros de flujo de NSG para mejorar la visibilidad de la red.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Los registros de flujo del grupo de seguridad de red (NSG) de Azure Network Watcher están deshabilitados"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-network-nsg-list' AND json.rule = flowLogsSettings does not exist or flowLogsSettings.enabled is false"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar el registro de flujo del grupo de seguridad de red (NSG) de Network Watcher, siga la siguiente URL:
https://docs.microsoft.com/en-us/azure/network-watcher/network-watcher-nsg-flow-logging-portal#enable-nsg-flow-log

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opmon2.csrs_id # op.mon2 Compliance Section UUID

   }

}



