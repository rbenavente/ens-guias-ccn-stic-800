resource "prismacloud_policy" "mp_com1_r3" {
   name = "Azure Network Security Group permite todo el tráfico en puertos que no se usan comúnmente"
   policy_type = "config"
   cloud_type = "azure"
   severity = "informational"
   description = <<-EOT
Esta política identifica que los grupos de seguridad no permitan todo el tráfico de Internet. Un grupo de seguridad actúa como un firewall virtual que controla el tráfico de una o más instancias. Los grupos de seguridad deben tener ACL restrictivas para permitir solo el tráfico entrante desde IP específicas a puertos específicos donde la aplicación está escuchando conexiones.
Los puertos que contempla esta política son:
20, 21, 22, 23, 25, 53, 80, 135, 137, 138, 443, 445, 1433, 1434, 3306, 3389, 4333, 5432, 5500, 5900, *)) or (destinationPortRanges is not empty and destinationPortRanges[*] is not member of (20, 21, 22, 23, 25, 53, 80, 135, 137, 138, 443, 445, 1433, 1434, 3306, 3389, 4333, 5432, 5500, 5900
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Azure Network Security Group permite todo el tráfico en puertos que no se usan comúnmente"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name= 'azure-network-nsg-list' AND json.rule = securityRules[?any(access equals Allow and direction equals Inbound and (sourceAddressPrefix equals Internet or sourceAddressPrefix equals * or sourceAddressPrefix equals 0.0.0.0/0 or sourceAddressPrefix equals ::/0) and (protocol equals Tcp or protocol equals Udp or protocol equals Icmp or protocol equals *) and ((destinationPortRange exists and destinationPortRange is not member of (20, 21, 22, 23, 25, 53, 80, 135, 137, 138, 443, 445, 1433, 1434, 3306, 3389, 4333, 5432, 5500, 5900, *)) or (destinationPortRanges is not empty and destinationPortRanges[*] is not member of (20, 21, 22, 23, 25, 53, 80, 135, 137, 138, 443, 445, 1433, 1434, 3306, 3389, 4333, 5432, 5500, 5900, *))) )] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
​Antes de realizar cualquier cambio, verifique el impacto en sus aplicaciones/servicios. Evalúe si desea editar la regla y limitar el acceso a usuarios, hosts y servicios específicos únicamente, denegar el acceso o eliminar la regla por completo.

1. Inicie sesión en el Portal de Azure.
2. Seleccione 'Todos los servicios'.
3. Seleccione 'Grupos de seguridad de red', en REDES.
4. Seleccione el grupo de seguridad de red que necesita modificar.
5. Seleccione 'Reglas de seguridad entrantes' en Configuración.
6. Seleccione la regla que necesita modificar y edítela para permitir direcciones IP específicas O configure la 'Acción' en 'Denegar' O 'Eliminar' la regla según sus requisitos.
7. 'Guarde' sus cambios.
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mpcom1.csrs_id # mp.com1 Compliance Section UUID

   }

}



