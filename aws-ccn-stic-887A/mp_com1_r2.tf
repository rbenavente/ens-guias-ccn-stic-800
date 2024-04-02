
resource "prismacloud_policy" "mp_com1_r2" {
   name = "Grupo de seguridad de AWS que permtie el tráfico de Internet"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica que los grupos de seguridad no permitan todo el tráfico de Internet. Un grupo de seguridad actúa como un firewall virtual que controla el tráfico de una o más instancias. Los grupos de seguridad deben tener ACL restrictivas para permitir solo el tráfico entrante desde IP específicas a puertos específicos donde la aplicación está escuchando conexiones.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Grupo de seguridad de AWS que permtie el tráfico de Internet"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ec2-describe-security-groups' AND json.rule = 'ipPermissions[*].ipRanges[*] contains 0.0.0.0/0 or ipPermissions[*].ipv6Ranges[*].cidrIpv6 contains ::/0'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

Si los grupos de seguridad reportados realmente necesitan restringir todo el tráfico, siga las instrucciones a continuación:
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el servicio 'VPC'
4. Haga clic en el 'Grupo de seguridad' específico de la alerta.
5. Haga clic en 'Reglas de entrada' y elimine la fila con el valor de IP como 0.0.0.0/0 o ::/0
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom1.csrs_id # mp.com1 Compliance Section UUID

   }
}



