
resource "prismacloud_policy" "mp_info6_r1" {
   name = "Backup plan automático no configurado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
AWS Backup es un servicio centralizado, completamente administrado y basado en políticas que permite proteger los datos de los clientes y garantizar el cumplimiento en todos los servicios de AWS para contribuir a la continuidad del negocio. Con AWS Backup, los clientes puede configurar de forma centralizada las políticas de protección de datos (copia de seguridad) y supervisar la actividad de copia de seguridad en los recursos de AWS, incluidos los volúmenes de Amazon EBS, las bases de datos de Amazon Relational Database Service (Amazon RDS) (incluidos los clústeres de Aurora), las tablas de Amazon DynamoDB, Amazon Elastic File System (Amazon EFS), los sistemas de archivos de Amazon FSx, las instancias de Amazon EC2 y los volúmenes de AWS Storage Gateway.
Para los procedimientos de respaldo de cualquiera de los dos entornos (local y nube) y siempre y cuando se utilicen recursos compatibles en el entorno local, la entidad puede hacer uso de AWS Backup, que permite elaboración de planes de respaldo y la definición de reglas de frecuencia, ciclo de vida, lugar de almacenamiento y etiquetado de las copias de seguridad.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Backup plan automático no configurado"
        criteria = "config from cloud.resource where api.name = 'aws-backup-backup-plan' AND json.rule = BackupPlan.Rules[*].ScheduleExpression does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT


EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpinfo6.csrs_id # mp.info6 Compliance Section UUID

  }
 
}



