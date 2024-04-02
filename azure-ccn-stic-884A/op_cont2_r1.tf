resource "prismacloud_policy" "op_cont2_r1" {
   name = "Crear una réplica de solo lectura del servidor PostgreSQL."
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Es una buena práctica el uso de "Read Replicas", o réplicas del servidor de solo lectura. Azure permite crear hasta cinco réplicas del server. Al ser estas réplicas de solo lectura, la información de estos servidores queda protegida contra escrituras erróneas o maliciosas. Sin embargo, hay que tener en cuenta el coste adicional que supone una réplica de solo lectura de un servidor.
  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Crear una réplica de solo lectura del servidor PostgreSQL."
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-postgresql-server' AND json.rule = \"configurations.value[?(@.name=='azure.replication_support')].properties.value equals OFF or configurations.value[?(@.name=='azure.replication_support')].properties.value equals off or configurations.value[?(@.name=='azure.replication_support')].properties.value does not exist\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte: https://learn.microsoft.com/es-es/azure/postgresql/single-server/concepts-read-replicas
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opcont2.csrs_id # op.cont2 Compliance Section UUID

   }

}



