
resource "prismacloud_policy" "op_exp10_r11" {
   name = "Clúster de AWS Redshift no está cifrado con la clave administrada por el cliente" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los clústeres de Redshift que están cifrados con claves KMS predeterminadas y no con claves administradas por el Cliente. Se recomienda utilizar claves KMS administradas por el cliente para cifrar los datos de sus bases de datos de Redshift. Las CMK administradas por el cliente le brindan más flexibilidad, incluida la capacidad de crear, rotar, deshabilitar, definir el control de acceso y auditar las claves de cifrado utilizadas para ayudar a proteger sus datos.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clúster de AWS Redshift no está cifrado con la clave administrada por el cliente"
        criteria = "config from cloud.resource where api.name = 'aws-redshift-describe-clusters' as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '$.X.encrypted is true and $.X.kmsKeyId equals $.Y.key.keyArn and $.Y.keyMetadata.keyManager contains AWS'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar el cifrado con la clave administrada por el cliente en su clúster de Redshift, siga los pasos mencionados en la siguiente URL:
https://docs.aws.amazon.com/redshift/latest/mgmt/changing-cluster-encryption.html

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



