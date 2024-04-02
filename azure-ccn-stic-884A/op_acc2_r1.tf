resource "prismacloud_policy" "op_acc2_r1" {
   name = "Requerir la autenticación multifactor a los usuarios"
   policy_type = "config"
   cloud_type = "azure"
   severity = "low"
   description = <<-EOT
Esta política identifica a los usuarios de Azure para los que AD MFA (autenticación multifactor de Active Directory) no está habilitado. Azure AD MFA es una práctica recomendada simple que agrega una capa adicional de protección además de su nombre de usuario y contraseña. MFA proporciona mayor seguridad para la configuración y los recursos de su cuenta de Azure. Habilitar la autenticación multifactor de Azure AD mediante directivas de acceso condicional es el enfoque recomendado para proteger a los usuarios.

Para mas detalles: 
https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-userstates

  EOT
   enabled = true
   labels = toset([
    "ENS-Azure",
  ])
   rule {
        name = "Requerir la autenticación multifactor a los usuarios"
        criteria = "config from cloud.resource where cloud.type = 'azure' AND api.name = 'azure-active-directory-credential-user-registration-details' AND json.rule = isMfaRegistered is false as X; config from cloud.resource where api.name = 'azure-active-directory-user' AND json.rule = accountEnabled is true as Y; filter '$.X.userDisplayName equals $.Y.displayName'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Para habilitar la autenticación multifactor de Azure AD por usuario; sigue la siguiente URL: 
https://docs.microsoft.com/en-us/azure/active-directory/authentication/howto-mfa-userstates
EOT

   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc2.csrs_id # op.acc2 Compliance Section UUID

   }
   compliance_metadata {
      compliance_id =  prismacloud_compliance_standard_requirement_section.opacc7.csrs_id # op.acc7 Compliance Section UUID

   }
}



