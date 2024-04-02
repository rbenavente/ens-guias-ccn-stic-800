
resource "prismacloud_policy" "mp_si2_r4" {
   name = "Snapshot de Instancia AWS RDS no cifrado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica instantáneas del clúster de AWS RDS DB (base de datos de servicio de base de datos relacional) que no están cifradas. Se recomienda encarecidamente implementar el cifrado en reposo cuando se trabaja con datos de producción que contienen información confidencial, para protegerlos del acceso no autorizado.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Snapshot de Instancia AWS RDS no cifrado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-rds-describe-db-snapshots' AND json.rule = 'snapshot.status equals available and snapshot.encrypted is false'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para configurar el cifrado del lado del servidor para la cola AWS SQS, siga la siguiente URL según sea necesario:
Puede cifrar una copia de una instantánea no cifrada. De esta manera, puede agregar rápidamente cifrado a una instancia de base de datos que previamente no estaba cifrada.
Siga los pasos a continuación para cifrar una copia de una instantánea no cifrada:
1. Inicie sesión en la consola de AWS.
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue al panel 'RDS' desde el menú desplegable 'Servicios'.
4. Haga clic en 'Instantánea' en el menú de la izquierda.
5. Seleccione la instantánea alertada.
6. En el menú desplegable 'Acción', seleccione 'Copiar instantánea'.
7. En la sección 'Configuración', desde 'Región de destino' seleccione una región,
8. Proporcione un identificador para la nueva instantánea en el campo 'Nuevo identificador de instantánea de base de datos'.
9.En la sección "Cifrado", seleccione "Habilitar cifrado".
10. Seleccione una clave maestra para el cifrado en el menú desplegable 'Clave maestra'.
11. Haga clic en 'Copiar instantánea'.

La instantánea de origen debe eliminarse una vez que la copia esté disponible.
Nota: Si elimina una instantánea de origen antes de que la instantánea de destino esté disponible, la copia de la instantánea puede fallar. Verifique que la instantánea de destino tenga el estado DISPONIBLE antes de eliminar una instantánea de origen.
EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



