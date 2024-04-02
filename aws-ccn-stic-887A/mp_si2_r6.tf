
resource "prismacloud_policy" "mp_si2_r6" {
   name = "Dominio AWS Elasticsearch no configurado con HTTPS"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los dominios de Elasticsearch que no están configurados con HTTPS. Los dominios de Amazon Elasticsearch permiten que todo el tráfico se envíe a través de HTTPS, lo que garantiza que todas las comunicaciones entre la aplicación y el dominio estén cifradas. Se recomienda habilitar HTTPS para que toda la comunicación entre la aplicación y todo el acceso a los datos pase por un canal de comunicación cifrado para eliminar los ataques de intermediario.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Dominio AWS Elasticsearch no configurado con HTTPS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-es-describe-elasticsearch-domain' AND json.rule = processing is false and domainEndpointOptions.enforceHTTPS is false"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue hasta el panel de Elasticsearch.
4. Haga clic en el dominio de Elasticsearch informado.
5. Haga clic en "Acciones", en el menú desplegable elija "Modificar cifrados".
6. En la página 'Modificar cifrados', seleccione 'Requerir HTTPS para todo el tráfico al dominio'.
7. Haga clic en Acpetar

EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



