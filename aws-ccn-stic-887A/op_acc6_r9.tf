resource "prismacloud_policy" "op_acc6_r9" {
   name = "AWS MFA no esta activo para los usuarios de acceso"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica a los usuarios de AWS IAM para quienes MFA no está habilitado. AWS Multi-Factor Authentication (MFA) es una práctica recomendada sencilla que agrega una capa adicional de protección además de su nombre de usuario y contraseña. Múltiples factores brindan mayor seguridad para la configuración y los recursos de su cuenta de AWS.
  EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS MFA no esta activo para los usuarios de acceso"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name='aws-iam-get-credential-report' AND json.rule='password_enabled equals true and mfa_active is false'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en AWS y navegue hasta el servicio 'IAM'.
2. Navegue hasta el usuario que fue reportado en la alerta.
3. En 'Credenciales de seguridad', marque "Dispositivo MFA asignado" y siga las instrucciones para habilitar MFA para el usuario.
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc6.csrs_id  # op.acc6 Compliance Section UUID

   }

}



