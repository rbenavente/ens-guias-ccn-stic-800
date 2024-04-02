resource "prismacloud_policy" "mp_com3_r4" {
   name = "AWS Elastic Load Balancer v2 (ELBv2) con escucha TLS/SSL no configurada"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los AWS Elastic Load Balancers v2 (ELBv2) que tienen escuchas no seguras. Como Load Balancers manejará todas las solicitudes entrantes y enrutará el tráfico en consecuencia. Los oyentes de los balanceadores de carga siempre deben recibir tráfico a través de un canal seguro con un certificado SSL válido configura
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Elastic Load Balancer v2 (ELBv2)con escucha TLS/SSL no configurada"
        criteria = "config from cloud.resource where api.name = 'aws-elbv2-describe-load-balancers' AND json.rule = state.code contains active and listeners[?any( protocol is member of (HTTP,TCP,UDP,TCP_UDP) and defaultActions[?any( redirectConfig.protocol contains HTTPS)] does not exist )] exists as X; config from cloud.resource where api.name = 'aws-elbv2-target-group' AND json.rule = targetType does not equal alb and protocol exists and protocol is not member of ('TLS', 'HTTPS') as Y; filter '$.X.listeners[?any( protocol equals HTTP or protocol equals UDP or protocol equals TCP_UDP )] exists or ( $.X.listeners[*].protocol equals TCP and $.X.listeners[*].defaultActions[*].targetGroupArn contains $.Y.targetGroupArn)'; show X;"
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
7. En el tipo de protocolo del equilibrador de carga es la aplicación, seleccione el protocolo de escucha como 'HTTPS (HTTP seguro)' o, si el tipo de equilibrador de carga es red, seleccione el protocolo de escucha como TLS.
8. Seleccione la 'Política de seguridad' adecuada
9. En la columna Certificado SSL, haga clic en 'Cambiar'
10. En el cuadro de diálogo emergente "Seleccionar certificado", elija un certificado de ACM o IAM o cargue un nuevo certificado según los requisitos y haga clic en "Guardar".
11. Vuelva al cuadro de diálogo 'Editar oyentes', revise la configuración de los oyentes seguros y luego haga clic en 'Guardar'

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



