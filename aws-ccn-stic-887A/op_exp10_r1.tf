resource "prismacloud_policy" "op_exp10_r1" {
   name = "Clúster AWS RDS DB cifrado con clave KMS predeterminada en lugar de CMK"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los clústeres de RDS DB (base de datos de servicio de base de datos relacional) que están cifrados utilizando la clave KMS predeterminada en lugar de CMK (clave maestra del cliente). Como práctica recomendada de seguridad, se debe utilizar CMK en lugar de la clave KMS predeterminada para el cifrado a fin de obtener la capacidad de rotar la clave de acuerdo con sus propias políticas, eliminar la clave y controlar el acceso a la clave a través de políticas KMS y políticas de IAM.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clúster AWS RDS DB cifrado con clave KMS predeterminada en lugar de CMK"
        criteria = "config from cloud.resource where api.name = 'aws-rds-db-cluster' as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '($.X.storageEncrypted is true) and ($.X.kmsKeyId equals $.Y.key.keyArn) and ($.Y.keyMetadata.keyManager does not contain CUSTOMER)' ; show X; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Los clústeres de base de datos RDS solo se pueden cifrar mientras se crea el clúster de base de datos. No puede convertir un clúster de base de datos no cifrado en uno cifrado. Sin embargo, puede restaurar una instantánea del clúster de base de datos de Aurora no cifrada en un clúster de base de datos de Aurora cifrado. Para hacer esto, especifique una clave de cifrado KMS cuando restaure desde la instantánea del clúster de base de datos no cifrada.

Paso 1: Para crear una 'instantánea' del clúster de base de datos no cifrado,
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_CreateSnapshotCluster.html
NOTA: Como no puede restaurar desde una instantánea del clúster de base de datos a un clúster de base de datos existente; Se crea un nuevo clúster de base de datos al restaurar. Una vez que el estado de la instantánea sea "Disponible".

Paso 2: Siga el enlace a continuación para restaurar el clúster desde una instantánea del clúster de base de datos.
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_RestoreFromSnapshot.html

Una vez que el clúster de base de datos esté restaurado y verificado, siga los pasos a continuación para eliminar el clúster de base de datos informado.
1. Inicie sesión en la Consola de administración de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue al panel 'RDS' desde el menú desplegable 'Servicios'
4. En el panel de navegación, elija "Bases de datos".
5. En la lista de instancias de base de datos, elija una instancia de escritor para el clúster de base de datos.
6. Elija "Acciones" y luego elija "Eliminar".
FMI:
1. Al eliminar un clúster de base de datos RDS, el cliente debe desactivar "Habilitar protección contra eliminación", de lo contrario, la instancia no se puede eliminar.
2. Al eliminar la instancia de base de datos de RDS, la aplicación de AWS le pedirá al usuario final que tome una instantánea final.
3. Si un clúster de base de datos RDS tiene una instancia de función de escritor, entonces el usuario debe eliminar la instancia de escritura para eliminar el clúster principal (la opción Eliminar no estará habilitada para el clúster de base de datos RDS principal).
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



