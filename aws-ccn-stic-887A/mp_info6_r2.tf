
resource "prismacloud_policy" "mp_info6_r2" {
   name = "Instancia de AWS RDS sin copia de seguridad automática"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica instancias de RDS que no están configuradas con la configuración de Copia de seguridad automática. Si se configura la Copia de seguridad automática, RDS crea una instantánea del volumen de almacenamiento de su instancia de base de datos, haciendo una copia de seguridad de toda la instancia de base de datos y no solo de las bases de datos individuales, lo que proporciona una recuperación en un momento dado. La copia de seguridad automática se realizará durante el período de copia de seguridad especificado y mantendrá las copias de seguridad durante un período de tiempo limitado, según se define en el período de retención. Se recomienda configurar copias de seguridad automáticas para sus servidores RDS críticos que ayudarán en el proceso de restauración de datos.

EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia de AWS RDS sin copia de seguridad automática"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-rds-describe-db-instances' AND json.rule = 'backupRetentionPeriod equals 0 or backupRetentionPeriod does not exist'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue a la consola de Amazon RDS
4. Elija Instancias y luego seleccione la instancia de base de datos informada.
5. En la lista desplegable "Acciones de instancia", elija "Modificar".
6. En la sección 'Copia de seguridad',
a. En la lista desplegable "Período de retención de copias de seguridad", seleccione la cantidad de días que desea que RDS conserve las copias de seguridad automáticas de esta instancia de base de datos.
b. Elija 'Hora de inicio' y 'Duración' en 'Ventana de copia de seguridad', que es el rango de tiempo diario (en UTC) durante el cual se crearon las copias de seguridad automáticas.
7. Haga clic en 'Continuar'
8. En la página de confirmación, elija 'Modificar instancia de base de datos' para guardar los cambios.

EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpinfo6.csrs_id # mp.info6 Compliance Section UUID

  }
 
}



