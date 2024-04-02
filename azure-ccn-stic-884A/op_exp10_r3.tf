resource "prismacloud_policy" "op_exp10_r3" {
   name = "Retencion minima de los flow logs : 365 dias"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Los registros de flujo de grupos de seguridad de red son una característica de Azure Network Watcher que le permite registrar información sobre el tráfico de IP que pasa por un grupo de seguridad de red. Para obtener más información sobre el registro de flujo del grupo de seguridad de red, consulte https://learn.microsoft.com/es-es/azure/network-watcher/network-watcher-nsg-flow-logging-overview

  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Retencion minima de los flow logs : 365 dias"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-network-nsg-list' AND json.rule = ($.flowLogsSettings.retentionPolicy.days < 365 or $.flowLogsSettings.retentionPolicy.enabled is false)"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte https://learn.microsoft.com/es-es/azure/network-watcher/nsg-flow-logs-tutorial
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

   }
 
}



