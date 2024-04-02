resource "prismacloud_policy" "op_acc6_r6" {
   name = "Política de contraseñas en AWS IAM insegura"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
"Las contraseñas de los usuarios deberán tener las siguientes normas de complejidad mínima y robustez: 
∙ Longitud mínima de 12 caracteres. 
∙ Al menos, una mayúscula. 
∙ Al menos, una minúscula. 
∙ Al menos, un número. 
∙ Al menos, un carácter especial."
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de contraseñas en AWS IAM insegura"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-iam-get-account-password-policy' AND json.rule =  'requireNumbers contains false and requireSymbols contains false and expirePasswords contains false and allowUsersToChangePassword contains false and requireLowercaseCharacters contains false and requireUppercaseCharacters contains false and maxPasswordAge does not exist and passwordReusePrevention does not exist and minimumPasswordLength==12'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'IAM'
2. Haga clic en 'Configuración de la cuenta'
3. En 'Política de contraseñas', seleccione y configure todas las opciones.
4. Haga clic en 'Aplicar política de contraseñas'

EOT
   remediation {
      cli_script_template = "aws iam update-account-password-policy --minimum-password-length 12 --require-uppercase-characters --require-lowercase-characters --require-numbers --require-symbols --allow-users-to-change-password --password-reuse-prevention 24 --max-password-age 90"
      description = "Este comando CLI requiere el permiso 'iam:UpdateAccountPasswordPolicy'. La ejecución exitosa actualizará la política de contraseñas para establecer la longitud mínima de la contraseña en 12, requerirá minúsculas, mayúsculas y símbolos, permitirá a los usuarios restablecer la contraseña, no podrá reutilizar las últimas 24 contraseñas y la caducidad de la contraseña será de 90 días."
   }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



