
resource "prismacloud_policy" "mp_s2_r2" {
   name = "API REST de AWS API Gateway no configurada con AWS Web Application Firewall v2 (AWS WAFv2)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica la API REST de AWS API Gateway que no está configurada con AWS Web Application Firewall. Como práctica recomendada, habilite el servicio AWS WAF en la API REST de API Gateway para protegerse contra ataques a la capa de aplicación. Para bloquear solicitudes maliciosas a su API REST de API Gateway, defina los criterios de bloqueo en la lista de control de acceso web WAF (web ACL
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "API REST de AWS API Gateway no configurada con AWS Web Application Firewall v2 (AWS WAFv2)"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-apigateway-get-stages' AND json.rule = webAclArn does not exist or webAclArn does not start with arn:aws:wafv2"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Asegúrese de que la API REST de API Gateway informada requiera WAF según sus requisitos y anote el nombre de la API REST de API Gateway.

Siga los pasos que se indican en la siguiente URL para asociar la API REST de API Gateway a WAF Web ACL.
https://docs.aws.amazon.com/waf/latest/developerguide/web-acl-associating-aws-resource.html


EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mps2.csrs_id # mp.s2 Compliance Section UUID

  }
 
}



