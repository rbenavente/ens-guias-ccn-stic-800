
resource "prismacloud_policy" "mp_si2_r5" {
   name = "Cluster AWS RDS con el cifrado deshabilitado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los clústeres de base de datos RDS para los cuales el cifrado está deshabilitado. Los clústeres de bases de datos cifrados de Amazon Aurora brindan una capa adicional de protección de datos al proteger sus datos del acceso no autorizado al almacenamiento subyacente. Puede utilizar el cifrado de Amazon Aurora para aumentar la protección de datos de sus aplicaciones implementadas en la nube y cumplir con los requisitos de cumplimiento para el cifrado de datos en reposo.
NOTA: Esta política se aplica solo a los clústeres de base de datos de Aurora.
https://docs.aws.amazon.com/cli/latest/reference/rds/describe-db-clusters.html
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Cluster AWS RDS con el cifrado deshabilitado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-rds-db-cluster' AND json.rule =  'storageEncrypted is false'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Los clústeres de base de datos de AWS solo se pueden cifrar mientras se crea el clúster de base de datos. No puede convertir un clúster de base de datos no cifrado en uno cifrado. Sin embargo, puede restaurar una instantánea del clúster de base de datos de Aurora no cifrada en un clúster de base de datos de Aurora cifrado. Para hacer esto, especifique una clave de cifrado KMS cuando restaure desde la instantánea del clúster de base de datos no cifrada.

ParaAWSRDS,
1. Para crear una 'instantánea' del clúster de base de datos no cifrado, siga las instrucciones mencionadas en el siguiente enlace:
Enlace RDS: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_CreateSnapshotCluster.html

NOTA: Como no puede restaurar desde una instantánea del clúster de base de datos a un clúster de base de datos existente; Se crea un nuevo clúster de base de datos al restaurar. Una vez que el estado de la instantánea sea "Disponible", elimine el clúster de base de datos no cifrado antes de restaurar desde la instantánea del clúster de base de datos siguiendo los pasos a continuación para AWS RDS:
a. Inicie sesión en la Consola de administración de AWS y abra la consola de Amazon RDS en https://console.aws.amazon.com/rds/
b. En el panel de navegación, elija "Bases de datos".
C. En la lista de instancias de base de datos, elija una instancia de escritor para el clúster de base de datos.
d. Elija "Acciones" y luego elija "Eliminar".

2. Para restaurar el clúster desde una instantánea del clúster de base de datos, siga las instrucciones mencionadas en el siguiente enlace:
Enlace RDS: https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_RestoreFromSnapshot.html

Para la base de datos de documentos de AWS,
1. Para crear una 'instantánea' del clúster de base de datos no cifrado, siga las instrucciones mencionadas en el siguiente enlace:
Enlace de base de datos del documento: https://docs.aws.amazon.com/documentdb/latest/developerguide/backup_restore-create_manual_cluster_snapshot.html

NOTA: Como no puede restaurar desde una instantánea del clúster de base de datos a un clúster de base de datos existente; Se crea un nuevo clúster de base de datos al restaurar. Una vez que el estado de la instantánea sea "Disponible", elimine el clúster de base de datos no cifrado antes de restaurar desde la instantánea del clúster de base de datos siguiendo los pasos a continuación para AWS Document DB:
   a. Inicie sesión en la Consola de administración de AWS y abra la consola de Amazon DocumentDB en https://console.aws.amazon.com/docdb/
   b. En el panel de navegación, elija "Clústeres".
   C. Seleccione el clúster de la lista que debe eliminarse
   d. Elija "Acciones" y luego elija "Eliminar".

2. Para restaurar el clúster desde una instantánea del clúster de base de datos, siga las instrucciones mencionadas en el siguiente enlace:
Enlace a la base de datos del documento: https://docs.aws.amazon.com/documentdb/latest/developerguide/backup_restore-restore_from_snapshot.html
EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



