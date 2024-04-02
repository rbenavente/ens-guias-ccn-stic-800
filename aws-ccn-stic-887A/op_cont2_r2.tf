resource "prismacloud_policy" "op_cont2_r2" {
   name = "AWS Classic Load Balancer no está configurado para abarcar varias zonas de disponibilidad"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los balanceadores de carga clásicos de AWS que no están configurados para abarcar varias zonas de disponibilidad. Classic Load Balancer no podrá redirigir el tráfico a destinos en otra zona de disponibilidad si la única zona de disponibilidad configurada deja de estar disponible. Como práctica recomendada, se recomienda configurar Classic Load Balancer para abarcar varias zonas de disponibilidad.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Classic Load Balancer no está configurado para abarcar varias zonas de disponibilidad"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elb-describe-load-balancers' AND json.rule = description.availabilityZones[*] size less than 2"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar AWS Classic Load Balancer para abarcar varias zonas de disponibilidad, siga los pasos que se mencionan en la siguiente URL:

https://docs.aws.amazon.com/elasticloadbalancing/latest/classic/enable-disable-az.html#add-availability-zone
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opcont2.csrs_id # op.cont2 Compliance Section UUID

   }
   
}



