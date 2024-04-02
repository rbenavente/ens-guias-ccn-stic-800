
resource "prismacloud_policy" "op_exp10_r17" {
   name = "Clave de AWS KMS configurada sin tag o alias" 
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica claves  que no tienen configurado algún tag. Se recomienda eSe recomienda utilizar tags y alias para una mejor gestión y administración de las claves.

  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clave de AWS KMS configurada sin tago alias"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-kms-get-key-rotation-status' AND json.rule = tags[*].key does not exist and tags[*].value does not exist and aliases[*] does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
   Para crear alias a las claves consulte: 
https://docs.aws.amazon.com/es_es/kms/latest/developerguide/kms-alias.html

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp10.csrs_id # op.exp10 Compliance Section UUID

  }
 
   
}



