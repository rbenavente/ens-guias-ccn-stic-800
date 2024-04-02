resource "prismacloud_policy" "mp_com3_r6" {
   name = "AWS CloudFront distribution utiliza protocolos SSL inseguros para la comunicación HTTPS"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
CloudFront, una red de entrega de contenido (CDN) ofrecida por AWS, no utiliza un cifrado seguro para la distribución. Una de las mejores prácticas de seguridad es exigir el uso de cifrados seguros TLSv1.0, TLSv1.1 y/o TLSv1.2 en la configuración de certificados de una distribución de CloudFront. Esta política busca cualquier desviación de esta práctica y devuelve los resultados.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS CloudFront distribution utiliza protocolos SSL inseguros para la comunicación HTTPS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudfront-list-distributions' AND json.rule = (origins.items[*] contains \"customOriginConfig\") and (origins.items[?(@.customOriginConfig.originSslProtocols.items)] contains \"SSLv3\")"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
La comunicación entre CloudFront y su origen personalizado debe exigir el uso de cifrados seguros. Modifique el protocolo SSL Origin de CloudFront Origin para incluir TLSv1.0, TLSv1.1 y/o TLSv1.2.

1. Vaya al panel de CloudFront de la consola de AWS.
2. Seleccione su ID de distribución.
3. Seleccione la pestaña 'Orígenes'.
4. Marque el origen que desea modificar y luego seleccione Editar.
5. Elimine (desmarque) 'SSLv3' de los protocolos SSL de origen.
6. Seleccione 'Sí, editar'.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom3.csrs_id # mp.com3 Compliance Section UUID

   }

}



