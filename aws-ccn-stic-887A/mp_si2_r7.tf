
resource "prismacloud_policy" "mp_si2_r7" {
   name = "Dominio AWS Elasticsearch sin cifrado de datos en reposo"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los dominios de Elasticsearch para los cuales el cifrado está deshabilitado. Se requiere el cifrado de datos en reposo para evitar que usuarios no autorizados accedan a la información confidencial disponible en los componentes de sus dominios de Elasticsearch. Esto puede incluir todos los datos de sistemas de archivos, índices primarios y de réplica, archivos de registro, archivos de intercambio de memoria e instantáneas automatizadas. Elasticsearch utiliza el servicio AWS KMS para almacenar y administrar las claves de cifrado. Se recomienda encarecidamente implementar el cifrado en reposo cuando se trabaja con datos de producción que contienen información confidencial, para protegerlos del acceso no autorizado.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Dominio AWS Elasticsearch sin cifrado de datos en reposo"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-es-describe-elasticsearch-domain' AND json.rule = 'processing is false and (encryptionAtRestOptions.enabled is false or encryptionAtRestOptions does not exist)'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar la función de cifrado en dominios existentes se requiere Elasticsearch 6.7 o posterior. Si su Elasticsearch 6.7 o posterior, siga los pasos a continuación para habilitar el cifrado en el dominio de Elasticsearch existente:
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el panel del servicio Elasticsearch.
4. Elija el dominio de Elasticsearch informado
5. Haga clic en el botón "Acciones", en el menú desplegable seleccione "Modificar cifrados".
6.En la página Modificar cifrados, seleccione la casilla de verificación "Habilitar cifrado de datos en reposo" y elija la clave KMS según sus necesidades. Se recomienda elegir KMS CMK en lugar del KMS predeterminado [Default(aws/es)]; para obtener un control más granular sobre los datos de su dominio Elasticsearch.
7. Haga clic en 'Enviar'.

Si su Elasticsearch es inferior a la versión 6.7, el cifrado de dominio de AWS Elasticsearch solo se puede configurar en el momento de la creación del dominio. Entonces, para solucionar esta alerta, cree un nuevo dominio con cifrado mediante claves KMS y luego migre todos los datos del dominio Elasticsearch requeridos desde el dominio Elasticsearch informado a este dominio recién creado.
Para configurar el nuevo dominio de Elasticsearch con cifrado mediante KMS Key, consulte la siguiente URL:
https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-createupdatedomains.html

Para eliminar el dominio ES informado, consulte la siguiente URL:
https://docs.aws.amazon.com/elasticsearch-service/latest/developerguide/es-gsg-deleting.html


EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



