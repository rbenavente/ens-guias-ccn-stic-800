resource "prismacloud_policy" "mp_com4_r1" {
   name = "Las subredes del AWS VPC no deberían permitir la asignación automática de IP pública"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las subredes de VPC que permiten la asignación automática de IP públicas. La subred de VPC es parte de la VPC y tiene sus propias reglas de tráfico. La asignación automática de la IP pública a la subred (al iniciar) puede exponer accidentalmente las instancias dentro de esta subred a Internet y debe editarse a "No" después de la creación de la subred.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Las subredes del AWS VPC no deberían permitir la asignación automática de IP pública"
        criteria = "config from cloud.resource where cloud.type = 'AWS' and api.name = 'aws-ec2-describe-subnets' AND json.rule = 'mapPublicIpOnLaunch is true'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS.
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue hasta el servicio 'VPC'.
4. En el panel de navegación, haga clic en 'Subredes'.
5. Seleccione la subred identificada y elija la opción 'Modificar la configuración de IP de asignación automática' en Acciones de subred.
6. Desactive la opción 'Asignar IP automáticamente' y guarde


EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom4.csrs_id # mp.com4 Compliance Section UUID

   }

}



