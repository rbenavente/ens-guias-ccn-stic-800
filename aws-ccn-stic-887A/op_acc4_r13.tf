resource "prismacloud_policy" "op_acc4_r13" {
   name = "Grupo AWS IAM con permisos de Acceso de Administrador"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los grupos de AWS IAM que tienen establecidos permisos de acceso de administrador. Esto permitiría que todos los usuarios de este grupo tuvieran privilegios administrativos. Como práctica recomendada de seguridad, se recomienda otorgar acceso con privilegios mínimos, como otorgar solo los permisos necesarios para realizar una tarea, en lugar de otorgar permisos excesivos.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
       name = "Grupo AWS IAM con permisos de Acceso de Administrador"
       criteria = "config from cloud.resource where api.name = 'aws-iam-list-groups' as X; config from cloud.resource where api.name = 'aws-iam-get-policy-version' AND json.rule = document.Statement[?any(Effect equals Allow and Action equals * and Resource equals * )] exists as Y; filter \"($.X.inlinePolicies[*].policyDocument.Statement[?(@.Effect=='Allow' && @.Resource=='*')].Action any equal * ) or ($.X.attachedPolicies[*].policyArn intersects $.Y.policyArn)\"; show X;"
       parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
   
1. Inicie sesión en la consola de AWS
2. Navegue al servicio IAM
3. Haga clic en Grupos
4. Haga clic en el grupo IAM informado.
5. En "Políticas administradas", haga clic en "Separar política" que tiene permisos excesivos y asigne una política de permisos limitados según sea necesario para un grupo en particular.
O
6. En "Políticas en línea", haga clic en "Editar política" o "Eliminar política" y asigne un permiso limitado según sea necesario para un grupo en particular.
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



