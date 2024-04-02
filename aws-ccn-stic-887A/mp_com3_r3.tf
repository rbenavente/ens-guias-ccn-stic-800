resource "prismacloud_policy" "mp_com3_r3" {
   name = "Política de negociación SSL en AWS Elastic Load Balancer v2 (ELBv2) con cifrados inseguros"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica Elastic Load Balancers v2 (ELBv2) que están configurados con una política de negociación SSL que contiene cifrados débiles. Un cifrado SSL es un algoritmo de cifrado que utiliza claves de cifrado para crear un mensaje codificado. Los protocolos SSL utilizan varios cifrados SSL para cifrar datos a través de Internet. Como muchos de los otros cifrados no son seguros o débiles, se recomienda utilizar solo los cifrados recomendados en el siguiente enlace de AWS: https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener .html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de negociación SSL en AWS Elastic Load Balancer v2 (ELBv2) con cifrados inseguros"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elbv2-describe-load-balancers' AND json.rule = listeners[?any(sslPolicy contains ELBSecurityPolicy-TLS-1-0-2015-04)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Vaya al Panel de EC2 y seleccione 'Equilibradores de carga'
4. Haga clic en el balanceador de carga informado.
5. En la pestaña 'Escuchas', elija la regla 'HTTPS' o 'SSL'; Haga clic en 'Editar', cambie 'Política de seguridad' a otra que no sea 'ELBSecurityPolicy-TLS-1-0-2015-04', ya que contiene el cifrado DES-CBC3-SHA, que es un cifrado débil.
6. Haga clic en 'Actualizar' para guardar los cambios.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



