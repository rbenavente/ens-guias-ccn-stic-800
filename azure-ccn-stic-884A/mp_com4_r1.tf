resource "prismacloud_policy" "mp_com4_r1" {
   name = "Asociar a todas las subnets un NSG que restrinja el tráfico no deseado"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Una VNET es una red privada en Azure qué, además, aporta las ventajas de la infraestructura en Azure, como la escalabilidad, la disponibilidad y el aislamiento. 
Para segmentar correctamente el trafico se recomienda asociar a todas las subnets un NSG que restrinja el tráfico no deseado.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Asociar a todas las subnets un NSG que restrinja el tráfico no deseado"
        criteria = "config from cloud.resource where api.name = 'azure-network-subnet-list' and json.rule = networkSecurityGroupId does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte https://learn.microsoft.com/en-us/azure/virtual-network/manage-network-security-group?tabs=network-security-group-portal

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpcom4.csrs_id # mp.com4 Compliance Section UUID

   }

}



