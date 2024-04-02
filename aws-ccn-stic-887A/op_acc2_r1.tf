resource "prismacloud_policy" "op_acc2_r1" {
   name = "Instancia AWS EC2 no configurada con Instance Metadata Service v2 (IMDSv2)"
   policy_type = "config"
   cloud_type = "aws"
   severity = "high"
   description = <<-EOT
  Esta política identifica instancias de AWS que no están configuradas con Instance Metadata Service v2 (IMDSv2). Con IMDSv2, cada solicitud ahora está protegida mediante autenticación de sesión. En caso de utilizar el servicio IMDS (metadatos de instancia y datos del usuario) se recomienda encarecidamente el uso de la versión 2 del servicio.
  
  Mas detalles:https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Instancia AWS EC2 no configurada con Instance Metadata Service v2 (IMDSv2)"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-ec2-describe-instances' AND json.rule = state contains running and metadataOptions.httpEndpoint equals enabled and metadataOptions.httpTokens does not contain required"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
  1. Inicie sesión en la consola de AWS
  2. En la consola, seleccione la región específica del menú desplegable de regiones en la esquina superior derecha para la cual se genera la alerta.
  3. Consulte la sección 'Configurar opciones de metadatos de instancias para instancias existentes' en la siguiente URL
  https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/configuring-instance-metadata-service.html
  
  NOTA: Tome precauciones antes de imponer el uso de IMDSv2, ya que las aplicaciones o agentes que usan IMDSv1, por ejemplo, el acceso a metadatos, se interrumpirán.
  EOT
   remediation {
      cli_script_template = "aws ec2 modify-instance-metadata-options --instance-id  'resourceId' --region 'region' --http-tokens required --http-endpoint enabled"
      description = "Este comando  CLI requiere  el permisos  'ec2:ModifyInstanceMetadataOptions'. La ejecución exitosa habilitará el Servicio de metadatos de instancia v2 (IMDSv2) en su instancia EC2."
   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc2.csrs_id # op.acc2 Compliance Section UUID
 # Compliance Section UUID

   }

}



