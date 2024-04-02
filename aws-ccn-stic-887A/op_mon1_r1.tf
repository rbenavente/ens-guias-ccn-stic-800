resource "prismacloud_policy" "op_mon1_r1" {
   name = "VPC Flow Logs no activos"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las VPC que tienen registros de flujo deshabilitados. Los registros de flujo de VPC capturan información sobre el tráfico IP que va hacia y desde las interfaces de red en su VPC. Los registros de flujo se utilizan como herramienta de seguridad para monitorear el tráfico que llega a sus instancias. Sin los registros de flujo activados, no es posible obtener visibilidad del tráfico de la red.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "VPC Flow Logs no activos"
        criteria = "config from cloud.resource where api.name = 'aws-ec2-describe-flow-logs' as X; config from cloud.resource where api.name = 'aws-ec2-describe-vpcs' AND json.rule = shared is false as Y; filter 'not($.X.resourceId equals $.Y.vpcId)' ; show Y; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue al Panel de VPC
4. Haga clic en 'Sus VPC' y elija la VPC reportada.
5. Haga clic en la pestaña 'Registros de flujo' y siga las instrucciones que se muestran en el enlace siguiente para habilitar los registros de flujo para la VPC:
https://aws.amazon.com/blogs/aws/vpc-flow-logs-log-and-view-network-traffic-flows/
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon1.csrs_id # op.mon1 Compliance Section UUID

  }
 
   
}



