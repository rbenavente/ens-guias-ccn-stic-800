
resource "prismacloud_policy" "mp_si2_r9" {
   name = "Snapshot volumen AWS EBS no cifrado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Se deberá asegurar el cifrado de las copias de seguridad (snapshots) de EBS.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Snapshot volumen AWS EBS no cifrado"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ec2-describe-snapshots' AND json.rule = snapshot.encrypted is false or snapshot.kmsKeyId does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la siguiente URL:
https://docs.aws.amazon.com/es_es/AWSEC2/latest/WindowsGuide/EBSEncryption.html

EOT



   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



