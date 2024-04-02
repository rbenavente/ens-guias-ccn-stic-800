resource "prismacloud_policy" "op_mon3_r1" {
   name = "Base de datos de AWS Redshift no tiene habilitado el registro de auditoría"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
El registro de auditoría no está habilitado de forma predeterminada en Amazon Redshift. Cuando habilita el registro en su clúster, Amazon Redshift crea y carga registros en Amazon S3 que capturan datos desde la creación del clúster hasta el momento actual.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Base de datos de AWS Redshift no tiene habilitado el registro de auditoría"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-redshift-describe-clusters' AND json.rule ='loggingStatus.loggingEnabled is false' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS.
2. Ir al servicio Amazon Redshift
3. En el panel de navegación izquierdo, haga clic en Clústeres.
4. Haga clic en el grupo reportado.
5. Haga clic en la pestaña Base de datos y elija 'Configurar registro de auditoría'.
6. En Habilitar registro de auditoría, elija "Sí".
7. Cree un nuevo depósito s3 o utilice un depósito existente
8. haga clic en Guardar

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id # op.mon3 Compliance Section UUID

  }
 
   
}



