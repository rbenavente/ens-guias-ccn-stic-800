resource "prismacloud_policy" "mp_com1_r4" {
   name = "Grupo de seguridad de AWS que permtie el tráfico de Internet a servicios críticos"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los grupos de seguridad que permiten todo el tráfico de Internet a uno de estos servicios. 
SSH (TCP/22) RDP (TCP/3389) Oracle (TCP/1521 y TCP/2483) MySQL (TCP/3306) Postgres (TCP/5432) Redis (TCP/6379) MongoDB (TCP/27017 y TCP/27018) Cassandra (TCP/7199, TCP/8888 y TCP/9160) Memcached (TCP/11211)

Un grupo de seguridad actúa como un firewall virtual que controla el tráfico de una o más instancias. Los grupos de seguridad deben tener ACL restrictivas para permitir solo el tráfico entrante desde IP específicas a puertos específicos donde la aplicación está escuchando conexiones.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Grupo de seguridad de AWS que permtie el tráfico de Internet a servicios críticos"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-ec2-describe-security-groups' AND json.rule = isShared is false and (ipPermissions[?any((ipRanges[*] contains 0.0.0.0/0 or ipv6Ranges[*].cidrIpv6 contains ::/0) and (toPort == 22 or fromPort == 22) or (toPort ==3389 and fromPort ==3389) or (toPort ==1521 and fromPort ==1521) or (toPort ==2483 and fromPort ==2483) or (toPort ==3306 and fromPort ==3306) or (toPort ==5432 and fromPort ==5432) or (toPort ==6379 and fromPort ==6379) or (toPort ==27017 and fromPort ==27017) or (toPort ==27018 and fromPort ==27018)or (toPort ==7199 and fromPort ==7199) or (toPort ==8888 and fromPort ==8888) or (toPort ==9160 and fromPort ==9160) or (toPort ==11211 and fromPort ==11211))] exists)"
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



