resource "prismacloud_policy" "mp_com3_r7" {
   name = "AWS CloudFront distribution utiliza una versión insegura de TLS"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica las distribuciones web de AWS CloudFront que están configuradas con versiones TLS para la comunicación HTTPS entre los espectadores y CloudFront. Como práctica recomendada, utilice TLSv1.2_2021 recomendado como versión mínima del protocolo en sus políticas de seguridad de distribución de CloudFront.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS CloudFront distribution utiliza una versión insegura de TLS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudfront-list-distributions' AND json.rule = viewerCertificate.certificateSource does not contain cloudfront and viewerCertificate.minimumProtocolVersion does not equal TLSv1.2_2021"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de distribuciones de CloudFront.
3. Haga clic en la distribución reportada.
4. En la pestaña "General", haga clic en el botón "Editar" en "Configuración".
5. En la página 'Editar distribución', establezca 'Política de seguridad' en TLSv1.2_2021.
6. Haga clic en 'Guardar cambios'

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



