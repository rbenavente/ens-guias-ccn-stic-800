
resource "prismacloud_policy" "op_exp10_r5" {
   name = "Cifrado del clúster AWS ElastiCache Redis no está configurado con la clave CMK" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los clústeres de ElastiCache Redis que están cifrados utilizando la clave KMS predeterminada en lugar de la CMK (clave maestra del cliente) administrada por el cliente o la clave CMK utilizada para el cifrado está deshabilitada. Como práctica recomendada de seguridad, se debe utilizar CMK habilitada en lugar de la clave KMS predeterminada para el cifrado a fin de obtener la capacidad de rotar la clave de acuerdo con sus propias políticas, eliminar la clave y controlar el acceso a la clave a través de políticas KMS y políticas de IAM.

Para detalles:
https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/at-rest-encryption.html#using-customer-managed-keys-for-elasticache-security
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Cifrado del clúster AWS ElastiCache Redis no está configurado con la clave CMK"
        criteria = "config from cloud.resource where api.name = 'aws-elasticache-describe-replication-groups' AND json.rule = status equals available and atRestEncryptionEnabled is true as X; config from cloud.resource where api.name = 'aws-kms-get-key-rotation-status' as Y; filter '($.X.kmsKeyId does not exist) or ($.X.kmsKeyId exists and $.Y.keyMetadata.keyState equals Disabled) and $.X.kmsKeyId equals $.Y.keyMetadata.arn'; show X; "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para cifrar su clúster de ElastiCache Redis con CMK, siga la URL que se menciona a continuación:
https://docs.aws.amazon.com/AmazonElastiCache/latest/red-ug/at-rest-encryption.html#at-reset-encryption-enable-existing-cluster

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



