resource "prismacloud_policy" "op_mon3_r10" {
   name = "Logs no exportado a un bucket AWS S3"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los logs de CloudTrail que no se estan exportando a un bucket de AWS S3. Para el almacenamiento a largo plazo de los datos de registro, es recomendable que estos se exporten a Amazon S3, definiendo previamente el ciclo de vida de los logs e identificando qué se necesita almacenar en frío.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Logs no exportado a un bucket AWS S3"
        criteria = "config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' AND json.rule = s3BucketName does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la guía de configuración: https://docs.aws.amazon.com/es_es/awscloudtrail/latest/userguide/cloudtrail-create-and-update-an-organizational-trail-by-using-the-aws-cli.html

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opmon3.csrs_id  # op.mon3 Compliance Section UUID

  }
 
   
}



