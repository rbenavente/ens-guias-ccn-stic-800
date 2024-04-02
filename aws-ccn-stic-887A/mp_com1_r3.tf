resource "prismacloud_policy" "mp_com1_r3" {
   name = "Grupo de seguridad de AWS no usado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los grupos de seguridad nque no esta siendo usado. Se recomienda evitar tener un repositorio de Security Groups que no estén siendo usados.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Grupo de seguridad de AWS no usado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-ec2-describe-security-groups' as X; config from cloud.resource where api.name = 'aws-ec2-describe-network-interfaces' AND json.rule = attachment.status contains \"attached\" or attachment.status contains \"in-use\" as Y; filter 'not ( $.Y.groups[*].groupId contains $.X.groupId ) ' ; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

Si los grupos de seguridad reportados no son necesario siga las instrucciones a continuación:
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el servicio 'VPC'
4. Elimine el 'Grupo de seguridad' específico de la alerta.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom1.csrs_id # mp.com1 Compliance Section UUID

   }

}



