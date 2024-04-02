resource "prismacloud_policy" "op_mon3_r7" {
   name = "Logging deshabilitado para el servicio AWS Web Application Firewall v2 (AWS WAFv2)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica Web Application Firewall v2 (AWS WAFv2) para los cuales el registro está deshabilitado. Al habilitar el registro WAFv2, se registran todas las solicitudes web inspeccionadas por el servicio que se pueden utilizar para depuración y análisis forenses adicionales. Los registros ayudarán a comprender por qué se activan determinadas reglas y por qué se bloquean determinadas solicitudes web. También puede integrar los registros con cualquier SIEM y herramientas de análisis de registros para su posterior análisis. Se recomienda habilitar el inicio de sesión en su Web Application Firewall v2 (WAFv2).

Para detalles:
https://docs.aws.amazon.com/waf/latest/developerguide/logging.html#logging-management

NOTA: Los recursos WAFv2 globales (CloudFront) están fuera del alcance de esta política.

  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Logging deshabilitado para el servicio AWS Web Application Firewall v2 (AWS WAFv2)"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-waf-v2-web-acl-resource' AND json.rule = '(resources.applicationLoadBalancer[*] exists or resources.apiGateway[*] exists or resources.other[*] exists) and loggingConfiguration.resourceArn does not exist'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar el inicio de sesión en sus WAFv2 informados, siga la URL que se menciona a continuación:
https://docs.aws.amazon.com/waf/latest/developerguide/logging.html#logging-management

NOTA: No hay costo adicional para habilitar el inicio de sesión en AWS WAFv2 (menos Kinesis Firehose y cualquier costo de almacenamiento).
Para Kinesis Firehose o cualquier cargo adicional de almacenamiento, consulte https://aws.amazon.com/cloudwatch/pricing/

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id  # op.mon3 Compliance Section UUID

  }
 
   
}



