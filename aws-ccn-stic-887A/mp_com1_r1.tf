resource "prismacloud_policy" "mp_com1_r1" {
   name = "Grupo de seguridad predeterminado de AWS no restringe todo el tráfico"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los grupos de seguridad predeterminados que no restringen el tráfico entrante y saliente. Una VPC viene con un grupo de seguridad predeterminado cuya configuración inicial niega todo el tráfico entrante y permite todo el tráfico saliente. Si no especifica un grupo de seguridad cuando lanza una instancia, la instancia se asigna automáticamente a este grupo de seguridad predeterminado. Como resultado, la instancia puede enviar tráfico saliente accidentalmente. Se recomienda eliminar las reglas de entrada y salida en el grupo de seguridad predeterminado y no adjuntar el grupo de seguridad predeterminado a ningún recurso.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Grupo de seguridad predeterminado de AWS no restringe todo el tráfico"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ec2-describe-security-groups' AND json.rule = '((groupName == default) and (ipPermissions[*] is not empty or ipPermissionsEgress[*] is not empty))'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Antes de realizar cualquier cambio, verifique el impacto en sus aplicaciones/servicios.

Para recursos asociados con el grupo de seguridad alertado:
1. Identifique los recursos de AWS que existen dentro del grupo de seguridad predeterminado.
2. Cree un conjunto de grupos de seguridad con privilegios mínimos para esos recursos.
3. Colocar los recursos en esos grupos de seguridad.
4. Elimine los recursos asociados del grupo de seguridad predeterminado.

Para grupos de seguridad alertados:
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable 'Región' en la esquina superior derecha para la cual se genera la alerta.
3. Navegue hasta el servicio 'VPC'
4. Para cada región, haga clic en 'Grupos de seguridad' específicos de la alerta.
5. En la sección 'Reglas de entrada', haga clic en 'Editar reglas de entrada' y elimine la regla existente, haga clic en 'Guardar'
6. En la sección "Reglas de salida", haga clic en "Editar reglas de salida" y elimine la regla existente, haga clic en "Guardar".
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom1.csrs_id # mp.com1 Compliance Section UUID

   }

}



