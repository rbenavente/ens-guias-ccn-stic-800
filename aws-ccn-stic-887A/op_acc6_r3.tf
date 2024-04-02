resource "prismacloud_policy" "op_acc6_r3" {
   name = "Clave de acceso de AWS no usada en los ultimos 90 días"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica a los usuarios de IAM cuyas claves de acceso no se utilizan durante más de 90 días. Las claves de acceso permiten a los usuarios acceder mediante programación a los recursos. Sin embargo, si alguna clave de acceso no se ha utilizado en los últimos 90 días, entonces esa clave de acceso debe eliminarse (aunque la clave de acceso esté inactiva).
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Clave de acceso de AWS no usada en los ultimos 90 días"
        criteria = "config from cloud.resource where cloud.type ='aws' and api.name = 'aws-iam-get-credential-report' AND json.rule = '(access_key_1_active is true and ((access_key_1_last_used_date != N/A and _DateTime.ageInDays(access_key_1_last_used_date) > 90) or (access_key_1_last_used_date == N/A and access_key_1_last_rotated != N/A and _DateTime.ageInDays(access_key_1_last_rotated) > 90))) or (access_key_2_active is true and ((access_key_2_last_used_date != N/A and _DateTime.ageInDays(access_key_2_last_used_date) > 90) or (access_key_2_last_used_date == N/A and access_key_2_last_rotated != N/A and _DateTime.ageInDays(access_key_2_last_rotated) > 90)))'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para eliminar la clave de acceso del usuario de AWS informada, siga la URL que se menciona a continuación:
https://aws.amazon.com/premiumsupport/knowledge-center/delete-access-key/
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



