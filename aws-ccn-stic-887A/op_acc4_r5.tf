resource "prismacloud_policy" "op_acc4_r5" {
   name = "Política de AWS IAM que permite asumir los permisos de un rol en todos los servicios"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica la política de AWS IAM que permite asumir permisos de rol en todos los servicios. Normalmente, AssumeRole se usa si tiene varias cuentas y necesita acceder a los recursos de cada cuenta, luego puede crear credenciales a largo plazo en una cuenta y luego usar credenciales de seguridad temporales para acceder a todas las demás cuentas asumiendo roles en esas cuentas.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política de AWS IAM que permite asumir los permisos de un rol en todos los servicios"
        criteria = "config from cloud.resource where cloud.type = 'aws' and api.name = 'aws-iam-get-policy-version' AND json.rule = isAttached is true and document.Statement[?any(Effect equals Allow and Action contains sts:AssumeRole and Resource anyStartWith * and Condition does not exist)] exists and policyArn does not contain iam::aws"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'IAM'.
3. Identificar la política reportada
4. Cambie el elemento Servicio del documento de política para que sea más restrictivo, de modo que solo permita el permiso AssumeRole en servicios seleccionados.

EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



