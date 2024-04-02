resource "prismacloud_policy" "op_exp7_r1" {
   name = "Logs de acceso a AWS CloudFront no activos"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta politica detecta si esta habilitado los logs de acceso de Amazon CloudFront	
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Logs de acceso a AWS CloudFront no activos"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudfront-list-distributions' AND json.rule = logging.enabled is false "
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la documentación: https://docs.aws.amazon.com/es_es/AmazonCloudFront/latest/DeveloperGuide/logging-and-monitoring.html
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp7.csrs_id # op.exp7 Compliance Section UUID

  }
 
}



