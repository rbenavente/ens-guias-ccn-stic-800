
resource "prismacloud_policy" "op_exp10_r8" {
   name = "Rotación de la clave maestra del cliente (CMK) de AWS no está habilitada" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica las claves maestras del cliente (CMK) que no están habilitadas con la rotación de claves. AWS KMS (servicio de administración de claves) permite a los clientes crear claves maestras para cifrar datos confidenciales en diferentes servicios. Como práctica recomendada de seguridad, es importante rotar las claves periódicamente para que, si se ven comprometidas, los datos del servicio subyacente sigan seguros con las nuevas claves.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Rotación de la clave maestra del cliente (CMK) de AWS no está habilitada"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name='aws-kms-get-key-rotation-status' AND json.rule = keyMetadata.keyState equals Enabled and keyMetadata.keyManager equals CUSTOMER and keyMetadata.origin equals AWS_KMS and (rotation_status.keyRotationEnabled is false or rotation_status.keyRotationEnabled equals \"null\") and keyMetadata.customerMasterKeySpec equals SYMMETRIC_DEFAULT"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha, para la cual se genera la alerta.
3. Navegue hasta el Servicio de administración de claves (KMS)
4. Haga clic en 'Claves administradas por el cliente' (Panel izquierdo)
5. Seleccione la clave administrada por el cliente de KMS informada
6. En la pestaña 'Rotación de claves', habilite 'Rotar automáticamente esta CMK cada año'.
7. Haga clic en Guardar

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



