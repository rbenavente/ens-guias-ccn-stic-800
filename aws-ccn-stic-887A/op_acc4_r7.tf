resource "prismacloud_policy" "op_acc4_r7" {
   name = "Rol/usuario de AWS IAM con permisos no usados para eliminar CloudTrails o todos los permisos"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica roles/usuarios de IAM que tienen permiso de eliminación de CloudTrail no utilizado o permisos completos de CloudTrail. Como práctica recomendada de seguridad, se recomienda otorgar el acceso con privilegios mínimos, como otorgar solo los permisos necesarios para realizar una tarea, en lugar de otorgar permisos excesivos a un rol/usuario en particular. Ayuda a reducir el posible acceso inadecuado o no intencionado a su infraestructura crítica de CloudTrail.

EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Rol/usuario de AWS IAM con permisos no usados para eliminar CloudTrails o todos los permisos"
        criteria= "config from cloud.resource where api.name = 'aws-iam-service-last-accessed-details' AND json.rule = '(arn contains :role or arn contains :user) and serviceLastAccesses[?any(serviceNamespace contains cloudtrail and totalAuthenticatedEntities any equal 0)] exists' as X; config from cloud.resource where api.name = 'aws-iam-get-policy-version' AND json.rule = 'isAttached is true and (document.Statement[?any(Effect equals Allow and (Action[*] contains DeleteTrail or Action contains DeleteTrail or Action contains cloudtrail:* or Action[*] contains cloudtrail:*))] exists)' as Y; filter '($.Y.entities.policyRoles[*].roleName exists and $.X.arn contains $.Y.entities.policyRoles[*].roleName) or ($.Y.entities.policyUsers[*].userName exists and $.X.arn contains $.Y.entities.policyUsers[*].userName)'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

Si los roles con permiso de eliminación de CloudTrail no utilizado,
1. Inicie sesión en la consola de AWS
2. Navegar por el servicio IAM
3. Haga clic en Roles
4. Haga clic en el rol de IAM informado.
5. En la pestaña Permisos, en la sección 'Políticas de permisos', elimine las políticas que tienen permisos de CloudTrail o elimine la función si no es necesaria.

Si los usuarios con permiso de eliminación de CloudTrail no utilizado,
1. Inicie sesión en la consola de AWS
2. Navegar por el servicio IAM
3. Haga clic en Usuarios
4. Haga clic en usuario de IAM informado.
5. En la pestaña Permisos, en la sección 'Políticas de permisos', elimine las políticas que tienen permisos de CloudTrail o elimine el usuario si no es necesario.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id  # op.exp8 Compliance Section UUID

  }

}



