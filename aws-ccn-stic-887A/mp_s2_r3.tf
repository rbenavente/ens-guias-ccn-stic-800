
resource "prismacloud_policy" "mp_s2_r3" {
   name = "AWS Application Load Balancer (ALB) no configurado con AWS Web Application Firewall v2 (AWS WAFv2)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los balanceadores de carga de aplicaciones (ALB) de AWS que no están configurados con AWS Web Application Firewall v2 (AWS WAFv2). Como práctica recomendada, configure el servicio AWS WAFv2 en los balanceadores de carga de aplicaciones para protegerse contra ataques a la capa de aplicaciones. Para bloquear solicitudes maliciosas a los balanceadores de carga de su aplicación, defina los criterios de bloqueo en la lista de control de acceso web WAFv2 (ACL web).
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS Application Load Balancer (ALB) no configurado con AWS Web Application Firewall v2 (AWS WAFv2)"
        criteria = "config from cloud.resource where api.name = 'aws-waf-v2-web-acl-resource' AND json.rule = resources.applicationLoadBalancer[*] exists as X; config from cloud.resource where api.name = 'aws-elbv2-describe-load-balancers' AND json.rule = scheme equals internet-facing and type equals application as Y; filter 'not($.X.resources.applicationLoadBalancer[*] contains $.Y.loadBalancerArn)'; show Y;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Asegúrese de que el balanceador de carga de aplicaciones informado requiera WAF según sus requisitos y anote el nombre del balanceador de carga.
3. Navegue al panel de WAF y Shield
4. Haga clic en ACL web, en la sección AWS WAF del panel izquierdo.
5. Si no se crea la ACL web; cree una nueva ACL web y agregue el balanceador de carga de aplicaciones informado a los recursos de AWS asociados.
6. Si ya tiene Web ACL creada; Haga clic en Web ACL y agregue su balanceador de carga de aplicaciones informado a los recursos de AWS asociados.
EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mps2.csrs_id # mp.s2 Compliance Section UUID

  }
 
}



