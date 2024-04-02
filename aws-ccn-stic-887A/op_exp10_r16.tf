
resource "prismacloud_policy" "op_exp10_r16" {
   name = "Clave de AWS KMS deshabilitada" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica claves deshabilitads. AWS KMS nunca elimina las claves KMS a menos que las programe explícitamente para su eliminación y venza el periodo de espera obligatorio.
Se recomienda eliminar las claves deshabilitadas que no estén en uso y no mantengan ningún objeto o recurso cifrado, completando el ciclo de vida de la clave.
Para más detalles:
https://docs.aws.amazon.com/es_es/kms/latest/developerguide/deleting-keys.html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de claves de AWS KMS es demasiado permisiva"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-kms-get-key-rotation-status' AND json.rule = keyMetadata.keyState equals \"Disabled\""
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
   Para eliminar o programar la cancelación de claves por favor consulte: 
https://docs.aws.amazon.com/es_es/kms/latest/developerguide/deleting-keys-scheduling-key-deletion.html

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



