resource "prismacloud_policy" "mp_com3_r2" {
   name = "AWS Elastic Load Balancer con escucha TLS/SSL no configurada"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los AWS Elastic Load Balancers que tienen escuchas no seguras. Como Load Balancers manejará todas las solicitudes entrantes y enrutará el tráfico en consecuencia. Los oyentes de los balanceadores de carga siempre deben recibir tráfico a través de un canal seguro con un certificado SSL válido configura
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Elastic Load Balancer con escucha TLS/SSL no configurada"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elb-describe-load-balancers' AND json.rule = '((description.listenerDescriptions[*].listener.protocol equals HTTPS or description.listenerDescriptions[*].listener.protocol equals SSL) and (description.listenerDescriptions[*].listener.sslcertificateId is empty or description.listenerDescriptions[*].listener.sslcertificateId does not exist)) or description.listenerDescriptions[*].listener.protocol equals HTTP or description.listenerDescriptions[*].listener.protocol equals TCP'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue al panel de EC2
4. Haga clic en 'Equilibradores de carga' (Panel izquierdo)
5. Seleccione el ELB informado
6. En la pestaña Oyentes, haga clic en el botón 'Editar' debajo de los oyentes disponibles.
7. En el protocolo del equilibrador de carga, seleccione 'HTTPS (HTTP seguro)' o 'SSL (TCP seguro)'.
8. En la columna Certificado SSL, haga clic en 'Cambiar'
9. En el cuadro de diálogo emergente "Seleccionar certificado", elija un certificado de ACM o IAM o cargue un nuevo certificado según los requisitos y haga clic en "Guardar".
10. Vuelva al cuadro de diálogo 'Editar oyentes', revise la configuración de los oyentes seguros y luego haga clic en 'Guardar'.


EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



