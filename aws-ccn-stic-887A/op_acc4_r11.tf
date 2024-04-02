resource "prismacloud_policy" "op_acc4_r11" {
   name = "Política de AWS IAM que permite el escalado de privilegios"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica la política de AWS IAM que tiene permisos que pueden provocar una escalado de privilegios. Un atacante podría aprovechar la política de AWS IAM que tiene permisos débiles para elevar los privilegios. Se recomienda seguir el principio de privilegios mínimos para garantizar que la política de AWS IAM no tenga estos permisos confidenciales.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de AWS IAM que permite el escalado de privilegios"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-iam-get-policy-version' AND json.rule = isAttached is true and document.Statement[?any(Effect equals Allow and (Action contains iam:CreatePolicyVersion or Action contains iam:SetDefaultPolicyVersion or Action contains iam:PassRole or Action contains iam:CreateAccessKey or Action contains iam:CreateLoginProfile or Action contains iam:UpdateLoginProfile or Action contains iam:AttachUserPolicy or Action contains iam:AttachGroupPolicy or Action contains iam:AttachRolePolicy or Action contains iam:PutUserPolicy or Action contains iam:PutGroupPolicy or Action contains iam:PutRolePolicy or Action contains iam:AddUserToGroup or Action contains iam:UpdateAssumeRolePolicy or Action contains iam:*))] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la siguiente URL para eliminar los permisos débiles que se enumeran a continuación de las políticas de AWS IAM informadas.
https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-attach-detach.html#remove-policies-console

A continuación se detallan los permisos que pueden conducir a una escalado de privilegios,
iam:CreatePolicyVersion
iam:SetDefaultPolicyVersion
iam:PassRole
iam:CreateAccessKey
iam:CreateLoginProfile
iam:UpdateLoginProfile
iam:AttachUserPolicy
iam:AttachGroupPolicy
iam:AttachRolePolicy
iam:PutUserPolicy
iam:PutGroupPolicy
iam:PutRolePolicy
iam:AddUserToGroup
iam:UpdateAssumeRolePolicy
iam:*
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



