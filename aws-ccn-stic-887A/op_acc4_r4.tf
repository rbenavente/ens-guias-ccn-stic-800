resource "prismacloud_policy" "op_acc4_r4" {
   name = "Política AWS IAM aplicada al rol de ejecución de Lambdas demasiado permisiva"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica que el rol de ejecución de Lambda Functions tiene asociada una política de IAM demasiado permisiva. Las funciones Lambda que tienen una política demasiado permisiva podrían provocar un movimiento lateral en la cuenta o un aumento de privilegios cuando se vean comprometidos. Se recomienda encarecidamente tener la política de acceso con menos privilegios para proteger las funciones Lambda del acceso no autorizado.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política AWS IAM aplicada al rol de ejecución de Lambdas demasiado permisiva"
        criteria = "config from cloud.resource where api.name = 'aws-lambda-list-functions' as X; config from cloud.resource where api.name = 'aws-iam-list-roles' as Y; config from cloud.resource where api.name = 'aws-iam-get-policy-version' AND json.rule = isAttached is true and document.Statement[?any(Effect equals Allow and (Action equals '*' or Action contains :* or Action[*] contains :*) and (Resource equals '*' or Resource[*] anyStartWith '*') and Condition does not exist)] exists as Z; filter '$.X.role equals $.Y.role.arn and $.Y.attachedPolicies[*].policyName equals $.Z.policyName'; show Z;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Consulte la siguiente URL para otorgar permisos detallados y restrictivos a la política de IAM:
https://docs.aws.amazon.com/IAM/latest/UserGuide/access_policies_manage-edit.html#edit-managed-policy-console


EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id   # op.acc4 Compliance Section UUID

   }

}



