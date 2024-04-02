resource "prismacloud_policy" "op_mon3_r2" {
   name = "AWS Elastic Load Balancer v2 (ELBv2) con el registro de acceso deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica Elastic Load Balancers v2 (ELBv2) que tienen el registro de acceso deshabilitado. Los registros de acceso capturan información detallada sobre las solicitudes enviadas a su balanceador de carga y cada registro contiene información como la hora en que se recibió la solicitud, la dirección IP del cliente, las latencias, las rutas de solicitud y las respuestas del servidor. Puede utilizar estos registros de acceso para analizar patrones de tráfico y solucionar problemas.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Elastic Load Balancer v2 (ELBv2) con el registro de acceso deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-elbv2-describe-load-balancers' AND json.rule = \"state.code contains active and ['attributes'].['access_logs.s3.enabled'] contains false\" "
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
6. Haga clic en el menú desplegable "Acciones".
7. Haga clic en 'Editar atributos'
8. En el cuadro emergente 'Editar atributos del balanceador de carga', elija 'Habilitar' para 'Registros de acceso' y configure la ubicación de S3 donde desea almacenar los registros de ELB.
9. Haga clic en 'Guardar'

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

  }
 
   
}



