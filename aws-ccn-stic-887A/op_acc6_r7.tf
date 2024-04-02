resource "prismacloud_policy" "op_acc6_r7" {
   name = "Política de contraseñas en AWS IAM permite la reutilización de contraseñas"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
   Esta política identifica las políticas de IAM que permiten la reutilización de contraseñas. AWS IAM (Identity & Access Management) permite a los clientes proteger el acceso a la consola de AWS. Como práctica recomendada de seguridad, los clientes deben contar con políticas de contraseñas seguras.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de contraseñas en AWS IAM permite la reutilización de contraseñas"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-iam-get-account-password-policy' AND json.rule='isDefaultPolicy is true or passwordReusePrevention equals null or passwordReusePrevention !isType Integer or passwordReusePrevention < 1'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'.
2. Haga clic en 'Configuración de la cuenta', marque 'Evitar la reutilización de contraseñas'

EOT
   remediation {
      cli_script_template = "aws iam update-account-password-policy --minimum-password-length 12 --require-uppercase-characters --require-lowercase-characters --require-numbers --require-symbols --allow-users-to-change-password --password-reuse-prevention 24 --max-password-age 90"
      description = "Este comando CLI requiere el permiso 'iam:UpdateAccountPasswordPolicy'. La ejecución exitosa actualizará la política de contraseñas para establecer la longitud mínima de la contraseña en 14, requerirá minúsculas, mayúsculas y símbolos, permitirá a los usuarios restablecer la contraseña, no podrá reutilizar las últimas 24 contraseñas y la caducidad de la contraseña será de 90 días."
   }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



