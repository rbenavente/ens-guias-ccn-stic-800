resource "prismacloud_policy" "op_acc4_r9" {
   name = "Política de AWS IAM  que permite privilegios administrativos completos"
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
        name = "Política de AWS IAM  que permite privilegios administrativos completos"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-policy-version' AND json.rule = isAttached is true and document.Statement[?any(Action anyStartWith * and Resource equals * and Effect equals Allow)] exists and (policyArn exists and policyArn does not contain iam::aws:policy/AdministratorAccess)"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT

1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de IAM
3. En el panel de navegación, haga clic en Políticas y luego busque el nombre de la política reportada.
4. Seleccione la política, haga clic en 'Acciones de política', seleccione 'Detach'
5. Seleccione todos los usuarios, grupos y roles que tengan esta política adjunta. Haga clic en "Detach Policy".

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



