resource "prismacloud_policy" "mp_com1_r5" {
   name = "Función Lambda expuesta a Internet"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Función Lambda expuesta a Internet
 EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Función Lambda expuesta a Internet"
        criteria = "config from cloud.resource where resource.status = Active AND api.name = 'aws-lambda-list-functions' AND json.rule = vpcConfig does not exist "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpcom1.csrs_id # mp.com1 Compliance Section UUID

   }

}



