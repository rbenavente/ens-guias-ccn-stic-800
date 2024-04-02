
resource "prismacloud_policy" "op_exp10_r13" {
   name = "Parámetro AWS SSM no está cifrado" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica los parámetros de AWS SSM que no están cifrados. Los parámetros de AWS Systems Manager (SSM) que almacenan datos confidenciales, por ejemplo, contraseñas, cadenas de bases de datos y códigos de permiso, están cifrados para cumplir con los requisitos previos de seguridad y cumplimiento. Un parámetro SSM cifrado es cualquier información confidencial que debe conservarse y a la que se debe hacer referencia de forma protegida.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Parámetro AWS SSM no está cifrado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ssm-parameter' AND json.rule = 'type does not contain SecureString'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Vaya al Administrador del sistema
3. En el panel de navegación, haga clic en 'Almacenamiento de parámetros'
4. Elija el parámetro informado y transfiéralo a un nuevo parámetro con el tipo 'SecureString'
5. Elimine el parámetro informado haciendo clic en 'Eliminar'
6. Haga clic en 'Eliminar parámetros'
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



