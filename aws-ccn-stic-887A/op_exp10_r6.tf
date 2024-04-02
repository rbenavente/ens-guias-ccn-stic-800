
resource "prismacloud_policy" "op_exp10_r6" {
   name = "Base de datos  AWS RDS no está cifrada con la clave administrada por el cliente" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las bases de datos RDS que están cifradas con claves KMS predeterminadas y no con claves administradas por el cliente. Como práctica recomendada, utilice claves administradas por el cliente para cifrar los datos en sus bases de datos RDS y mantener el control de sus claves y datos en cargas de trabajo confidenciales.

  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Base de datos  AWS RDS no está cifrada con la clave administrada por el cliente"
        criteria = "config from cloud.resource where api.name = 'aws-rds-describe-db-instances' as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '$.X.storageEncrypted is true and $.X.kmsKeyId equals $.Y.key.keyArn and $.Y.keyMetadata.keyManager contains AWS'; show X; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Debido a que puede configurar el cifrado de la base de datos de AWS RDS solo durante la creación de la base de datos, el proceso para resolver esta alerta requiere que cree una nueva base de datos RDS con una clave de cifrado administrada por el cliente, migre los datos de la base de datos informada a esta base de datos recién creada y elimine la base de datos RDS identificada en la alerta.

Para crear una nueva base de datos RDS con cifrado mediante una clave administrada por el cliente:
1. Inicie sesión en la consola de AWS.
2. Seleccione la región para la cual se generó la alerta.
3. Navegue hasta el panel de Amazon RDS.
4. Seleccione 'Crear base de datos'.
5. En la página 'Seleccionar motor', seleccione 'Opciones de motor' y 'Siguiente'.
6. En la página 'Elegir caso de uso', seleccione 'Caso de uso' de la base de datos y 'Siguiente'.
7. En la página 'Especificar detalles de la base de datos', especifique los detalles de la base de datos que necesita y haga clic en 'Siguiente'.
Nota: El cifrado de Amazon RDS tiene algunas limitaciones en cuanto a instancias de tipo y región. Para conocer la disponibilidad de Amazon RDS Encryption, consulte: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Overview.Encryption.html#Overview.Encryption.Availability
8. En la página 'Configurar ajustes avanzados', en 'Cifrado', seleccione 'Habilitar cifrado' y seleccione la clave administrada por el cliente [es decir. Aparte de (predeterminado) aws/rds] de la lista desplegable 'Clave maestra'].
9. Seleccione 'Crear base de datos'.

Para eliminar la base de datos RDS que utiliza las CMK predeterminadas, que activaron la alerta:
1. Inicie sesión en la consola de AWS
2. Seleccione la región para la cual se generó la alerta.
3. Navegue hasta el panel de Amazon RDS.
4. Haga clic en Instancias y seleccione la base de datos RDS informada.
5. Seleccione el menú desplegable "Acciones de instancia" y haga clic en "Eliminar".
7. En el cuadro de diálogo 'Eliminar', seleccione '¿Crear instantánea final?' casilla de verificación, si desea una copia de seguridad. Proporcione un nombre para la instantánea final, confirme la eliminación y seleccione "Eliminar".
​
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



