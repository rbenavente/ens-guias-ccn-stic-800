resource "prismacloud_policy" "op_acc3_r1" {
   name = "Politica de AWS IAM aplicada a usuarios"
   policy_type = "config"
   cloud_type = "aws"
   severity = "high"
   description = <<-EOT
  Esta política identifica las políticas de IAM aplicadas a usuario. De forma predeterminada, los usuarios, grupos y roles de IAM no tienen acceso a los recursos de AWS. Las políticas de IAM son el medio por el cual se otorgan privilegios a usuarios, grupos o roles. Se recomienda que las políticas de IAM se apliquen directamente a los grupos pero no a los usuarios.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Politica de AWS IAM aplicada a usuarios"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-iam-list-attached-user-policies' AND json.rule='attachedPolicies isType Array and not attachedPolicies size == 0'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
  1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'IAM'.
3. Identifique los usuarios que fueron asignados específicamente a la política de IAM informada.
4. Si ya existe un grupo con una política similar, coloque al usuario en ese grupo. Si dicho grupo no existe, cree un nuevo grupo con la política relevante y asigne el usuario al grupo.

EOT

   compliance_metadata {
      compliance_id =prismacloud_compliance_standard_requirement_section.opacc3.csrs_id  # Compliance Section UUID

   }

}



