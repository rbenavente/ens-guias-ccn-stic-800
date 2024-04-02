resource "prismacloud_policy" "op_acc4_r15" {
   name = "Instancias AWS EC2 sin el agente SSM instalado"
   policy_type = "config"
   cloud_type = "aws"
   severity = "high"
   description = <<-EOT
Esta política identifica Instancias AWS EC2 que no tienen instalado el agente SSM. Con AWS Systems Manager Automation pueden utilizarse documentos de automatización y diseñar flujos de trabajo para la administración de cambios o la ejecución de operaciones estándar para administrar las instancias Amazon EC2 (p. ej., actualizar los sistemas operativos), en lugar de permitir el acceso directo.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
       name = "Instancias AWS EC2 sin el agente SSM instalado"
       criteria = "config from cloud.resource where cloud.account = 'SSull_AWS_New' AND api.name = 'aws-ec2-describe-instances' AND json.rule = tags[*].value contains SSM and iamInstanceProfile.arn does not contain SSM"
       parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para instalar el agente SSM consulte la siguiente URL:
https://docs.aws.amazon.com/es_es/systems-manager/latest/userguide/ssm-agent.html  

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp1.csrs_id  # op.exp1 Compliance Section UUID

   }
      compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp3.csrs_id  # op.exp3 Compliance Section UUID

   }
      compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp4.csrs_id  # op.exp4 Compliance Section UUID
   }

}



