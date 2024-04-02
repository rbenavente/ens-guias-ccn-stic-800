
resource "prismacloud_policy" "mp_s2_r1" {
   name = "Distribución web de AWS CloudFront con el servicio AWS Web Application Firewall (AWS WAF) deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las distribuciones web de Amazon CloudFront que tienen el servicio AWS Web Application Firewall (AWS WAF) deshabilitado. Como práctica recomendada, habilite el servicio AWS WAF en las distribuciones web de CloudFront para protegerse contra ataques a la capa de aplicaciones. Para bloquear solicitudes maliciosas a su red de entrega de contenido Cloudfront, defina los criterios de bloqueo en la lista de control de acceso web WAF (ACL web).
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Distribución web de AWS CloudFront con el servicio AWS Web Application Firewall (AWS WAF) deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudfront-list-distributions' AND json.rule = 'webACLId is empty'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Vaya al panel de distribuciones de CloudFront.
3. Haga clic en la distribución web informada.
4. En la pestaña "General", haga clic en el botón "Editar".
5. En la página 'Editar distribución', elija una 'ACL web de AWS WAF' del menú desplegable.
6. Haga clic en 'Sí, editar'

EOT



   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.mps2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



