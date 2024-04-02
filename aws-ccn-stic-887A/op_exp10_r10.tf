
resource "prismacloud_policy" "op_exp10_r10" {
   name = "Registro de AWS CloudTrail no cifrado mediante claves maestras de cliente (CMK)" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Comprueba que los registros de CloudTrail estén cifrados. AWS CloudTrail es un servicio que permite la gobernanza, el cumplimiento, la auditoría operativa y de riesgos de la cuenta de AWS. Es una práctica recomendada de cumplimiento y seguridad cifrar los datos de CloudTrail, ya que pueden contener información confidencial.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Registro de AWS CloudTrail no cifrado mediante claves maestras de cliente (CMK)"
        criteria = "config from cloud.resource where api.name='aws-cloudtrail-describe-trails' AND cloud.type = 'aws' AND json.rule = 'kmsKeyId does not exist'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'CloudTrail'.
2. Para cada rastro, en Configuración > Ubicación de almacenamiento, seleccione "Sí" para la configuración "Cifrar archivos de registro".
3.Elija una clave KMS existente o cree una nueva para cifrar los registros.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



