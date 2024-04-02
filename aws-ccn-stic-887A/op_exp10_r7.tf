
resource "prismacloud_policy" "op_exp10_r7" {
   name = "AWS DynamoDB cifrada utilizando CMK propiedad de AWS en lugar de la CMK administrada por AWS (KMS)" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las tablas de DynamoDB que utilizan CMK propiedad de AWS (predeterminada) en lugar de CMK administrada por AWS (KMS) para cifrar datos. La CMK administrada por AWS proporciona características adicionales, como la capacidad de ver la CMK y la política de claves, y auditar el cifrado y descifrado de tablas de DynamoDB.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS DynamoDB cifrada utilizando CMK propiedad de AWS en lugar de la CMK administrada por AWS (KMS)"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-dynamodb-describe-table' AND json.rule =  'ssedescription does not exist or (ssedescription exists and ssedescription.ssetype == AES256)' "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
3. Navegue hasta el panel 'DynamoDB'
4. Seleccione la tabla informada de la lista de tablas de DynamoDB.
5. En la pestaña "Descripción general", vaya a la sección "Detalles de la tabla".
6. Haga clic en el enlace 'Administrar cifrado' disponible para 'Tipo de cifrado'
7. En la ventana emergente 'Administrar cifrado', seleccione 'KMS' como tipo de cifrado.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
   
}



