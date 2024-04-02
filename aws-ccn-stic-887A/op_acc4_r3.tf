resource "prismacloud_policy" "op_acc4_r3" {
   name = "La política AWS IAM es demasiado permisiva para el servicio Lambda"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica las políticas de IAM que son demasiado permisivas para el servicio Lambda. AWS proporciona funcionalidad computacional sin servidor a través de su servicio Lambda. Las funciones sin servidor permiten a las organizaciones ejecutar código para aplicaciones o servicios backend sin aprovisionar máquinas virtuales o servidores de administración. Se recomienda seguir el principio de privilegios mínimos, asegurando que solo los servicios Lambda restringidos para recursos restringidos.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "La política AWS IAM es demasiado permisiva para el servicio Lambda"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-iam-get-policy-version' AND json.rule = isAttached is true and document.Statement[?any(Effect equals Allow and (Action equals lambda:* or Action[*] equals lambda:*) and (Resource equals * or Resource[*] equals *) and Condition does not exist)] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'IAM'
3. Haga clic en 'Políticas' en el panel izquierdo y haga clic en la política de IAM informada.
4. En la pestaña Permisos, cambie el elemento del documento de política para que sea más restrictivo de modo que solo permita permisos Lambda restringidos en recursos seleccionados en lugar de comodines (Lambda:* y Recurso:*) O Coloque la declaración de condición con acceso con privilegios mínimos.
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id # Compliance Section UUID

   }

}



