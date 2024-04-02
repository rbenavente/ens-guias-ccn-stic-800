resource "prismacloud_policy" "op_acc6_r13" {
   name = "AWS CloudTrail no está habilitado con multi-trail y no captura todos los eventos de administración"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica las cuentas de AWS que no tienen un CloudTrail con múltiples trails habilitados y que capturan todos los eventos de administración. AWS CloudTrail es un servicio que permite la gobernanza, el cumplimiento, la auditoría operativa y de riesgos de la cuenta de AWS. Es una práctica recomendada de cumplimiento y seguridad activar CloudTrail en diferentes regiones para obtener un seguimiento de auditoría completo de las actividades en varios servicios.

NOTA: Si tiene habilitado el Registro de la organización en su cuenta, esta política se puede deshabilitar o se pueden ignorar las alertas generadas para esta política en dicha cuenta; ya que Organization Trail de forma predeterminada habilita el registro de seguimiento para todas las cuentas de esa organización.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS CloudTrail no está habilitado con multi-trail y no captura todos los eventos de administración"
        criteria = "config from cloud.resource where api.name= 'aws-cloudtrail-describe-trails' AND json.rule = 'isMultiRegionTrail is true and includeGlobalServiceEvents is true' as X; config from cloud.resource where api.name= 'aws-cloudtrail-get-trail-status' AND json.rule = 'status.isLogging equals true' as Y; config from cloud.resource where api.name= 'aws-cloudtrail-get-event-selectors' AND json.rule = '(eventSelectors[*].readWriteType contains All and eventSelectors[*].includeManagementEvents equal ignore case true) or (advancedEventSelectors[*].fieldSelectors[*].equals contains \"Management\" and advancedEventSelectors[*].fieldSelectors[*].field does not contain \"readOnly\" and advancedEventSelectors[*].fieldSelectors[*].field does not contain \"eventSource\")' as Z; filter '($.X.trailARN equals $.Z.trailARN) and ($.X.name equals $.Y.trail)'; show X; count(X) less than 1"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte el siguiente enlace para crear/actualizar el sendero:
https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-create-and-update-a-trail.html

Consulte el siguiente enlace para obtener más información sobre el registro de eventos de administración:
Registro de eventos de administración - AWS CloudTrail

EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # opp.acc.6 Compliance Section UUID

     }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opexp8.csrs_id  # op.exp.8Compliance Section UUID

     }
     
   

}



