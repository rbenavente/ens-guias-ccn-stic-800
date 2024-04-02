resource "prismacloud_policy" "op_acc4_r12" {
   name = "AWS IAM Role con permisos de Acceso de Administrador"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los roles de AWS IAM que tienen establecidos permisos de acceso de administrador. Esto permitiría que todos los usuarios que asuman este rol tengan privilegios administrativos. Como práctica recomendada de seguridad, se recomienda otorgar acceso con privilegios mínimos, como otorgar solo los permisos necesarios para realizar una tarea, en lugar de otorgar permisos excesivos.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
       name = "AWS IAM Role con permisos de Acceso de Administrador"
       criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-list-roles' as X; config from cloud.resource where api.name = 'aws-iam-get-policy-version' as Y; filter \"($.X.inlinePolicies[*].policyDocument.Statement[?(@.Effect=='Allow' && @.Resource=='*')].Action any equal *) or ($.X.attachedPolicies[*].policyArn contains $.Y.policyArn and $.Y.document.Statement[?(@.Effect=='Allow' && @.Resource=='*')].Action any equal *)\"; show X;" 
       parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue al servicio IAM
3. Haga clic en Roles
4. Haga clic en el rol de IAM informado.
5. En 'Políticas de permisos', haga clic en 'X' para separar o eliminar la política que tiene permisos excesivos y asignar una política de permisos limitados según sea necesario para una función en particular.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id # op.acc4 Compliance Section UUID

   }

}



