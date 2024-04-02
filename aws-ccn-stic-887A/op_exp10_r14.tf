
resource "prismacloud_policy" "op_exp10_r14" {
   name = "Política de AWS IAM permite acciones de descifrado en todas las claves KMS" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica políticas de IAM que permiten acciones de descifrado en todas las CMK. En lugar de otorgar permisos para todas las claves, determine el conjunto mínimo de claves que los usuarios necesitan para acceder a los datos cifrados. Debe otorgar a las identidades solo los permisos kms:Decrypt o kms:ReEncryptFrom y solo para las claves necesarias para realizar una tarea. Al adoptar el principio de privilegio mínimo, puede reducir el riesgo de divulgación involuntaria de sus datos.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de AWS IAM permite acciones de descifrado en todas las claves KMS"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-iam-get-policy-version' AND json.rule = document.Statement[?any(Effect equals Allow and Resource equals * and (Action contains kms:* or Action contains kms:Decrypt or Action contains kms:ReEncryptFrom) and Condition does not exist)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para permitir que un usuario cifre y descifre con cualquier CMK en una cuenta de AWS específica; consulte el siguiente ejemplo:
https://docs.aws.amazon.com/kms/latest/developerguide/customer-managed-policies.html#iam-policy-example-encrypt-decrypt-one-account

Para permitir que un usuario cifre y descifre con cualquier CMK en una cuenta y región de AWS específicas; consulte el siguiente ejemplo:
https://docs.aws.amazon.com/kms/latest/developerguide/customer-managed-policies.html#iam-policy-example-encrypt-decrypt-one-account-one-region

Para permitir que un usuario cifre y descifre con CMK específicas; consulte el siguiente ejemplo:
https://docs.aws.amazon.com/kms/latest/developerguide/customer-managed-policies.html#iam-policy-example-encrypt-decrypt-specific-cmks
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



