resource "prismacloud_policy" "mp_com2_r1" {
   name = "Azure VPN no está configurado con algoritmo criptográfico"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica las VPN de Azure que no están configuradas con un algoritmo criptográfico. Puertas de enlace de VPN de Azure para usar una política IPsec/IKE personalizada con algoritmos criptográficos específicos y fortalezas clave, en lugar de los conjuntos de políticas predeterminados de Azure. El estándar de protocolo IPsec e IKE admite una amplia gama de algoritmos criptográficos en varias combinaciones. Si los clientes no solicitan una combinación específica de parámetros y algoritmos criptográficos, las puertas de enlace de VPN de Azure usan un conjunto de propuestas predeterminadas. Por lo general, debido a los requisitos de cumplimiento o seguridad, ahora puede configurar sus puertas de enlace VPN de Azure para usar una política IPsec/IKE personalizada con algoritmos criptográficos específicos y fortalezas clave, en lugar de los conjuntos de políticas predeterminados de Azure. Por lo tanto, se recomienda utilizar conjuntos de políticas personalizados y elegir una criptografía fuerte.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Azure VPN no está configurado con algoritmo criptográfico"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-network-vpn-connection-list' AND json.rule = 'ipsecPolicies is empty and connectionType does not equal ExpressRoute'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Siga la documentación de Microsoft Azure y configure sus respectivas conexiones VPN utilizando los estrictos requisitos criptográficos recomendados.
FMI: https://docs.microsoft.com/en-us/azure/vpn-gateway/vpn-gateway-about-compliance-crypto#cryptographic-requirements
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpcom2.csrs_id # mp.2Compliance Section UUID

   }

}



