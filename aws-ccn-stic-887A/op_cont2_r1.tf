resource "prismacloud_policy" "op_cont2_r1" {
   name = "Instancia de AWS RDS con zona de disponibilidad múltiple deshabilitada"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica instancias de RDS que tienen la zona de disponibilidad múltiple (Multi-AZ) deshabilitada. Cuando la instancia de base de datos de RDS está habilitada con Multi-AZ, RDS crea automáticamente una instancia de base de datos principal y replica sincrónicamente los datos en una instancia en espera en una zona de disponibilidad diferente. Estas implementaciones Multi-AZ mejorarán la accesibilidad del nodo primario al proporcionar una réplica de lectura en caso de pérdida de conectividad de red o pérdida de disponibilidad en la zona de disponibilidad del nodo primario para operaciones de lectura/escritura, haciéndolos la mejor opción para las cargas de trabajo de bases de datos de producción.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia de AWS RDS con zona de disponibilidad múltiple deshabilitada"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-rds-describe-db-instances' AND json.rule = dbinstanceStatus equals available and (engine does not contain aurora and engine does not contain sqlserver and engine does not contain docdb) and (multiAZ is false or multiAZ does not exist)"
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
5. Haga clic en 'Modificar'
6. En la sección "Disponibilidad y durabilidad" para la "Implementación Multi-AZ", seleccione "Crear una instancia en espera".
7. Haga clic en 'Continuar'
8. En "Programación de modificaciones", elija "Cuándo aplicar modificaciones".
9. En la página de confirmación, revise los cambios y haga clic en 'Modificar instancia de base de datos' para guardar los cambios.
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opcont2.csrs_id  # op.cont2 Compliance Section UUID

   }
   
}



