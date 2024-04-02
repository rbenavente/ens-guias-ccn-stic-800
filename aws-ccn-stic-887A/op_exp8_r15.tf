
resource "prismacloud_policy" "op_exp8_r15" {
   name = "Política del bucket AWS S3 permite el acceso público a los logs de CloudTrail"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política analiza la política de su depósito que se aplica al depósito de S3 para evitar el acceso público a los registros de CloudTrail. CloudTrail registra un registro de cada llamada API realizada en su cuenta de AWS. Estos archivos de registros se almacenan en un depósito de S3. La política del depósito o la lista de control de acceso (ACL) aplicada al depósito de S3 no impide el acceso público a los registros de CloudTrail. Se recomienda que la política de depósito o la lista de control de acceso (ACL) aplicada al depósito de S3 que almacena los registros de CloudTrail impida el acceso público. Permitir el acceso público al contenido del registro de CloudTrail puede ayudar a un adversario a identificar debilidades en el uso o la configuración de la cuenta afectada.

EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política del bucket AWS S3 permite el acceso público a los logs de CloudTrail"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-cloudtrail-describe-trails' as X; config from cloud.resource where api.name = 'aws-s3api-get-bucket-acl' as Y; filter \"($.Y.bucketName==$.X.s3BucketName) and ($.Y.acl.grants[*].grantee contains AllUsers or $.Y.acl.grants[*].permission contains FullControl) and ($.Y.policy.Statement[?(@.Principal=='*' && @.Effect=='Allow')].Action contains s3:* or $.Y.policy.Statement[?(@.Principal.AWS=='*' && @.Effect=='Allow')].Action contains s3:*)\" ; show Y;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Ir a S3
3. Elija el depósito S3 informado y haga clic en Propiedades
4. En el panel Propiedades, haga clic en la pestaña Permisos.
5. Si el botón Editar política de depósito está presente, selecciónelo.
6. Elimine cualquier declaración que tenga un efecto. Establezca en 'Permitir' y un principal establecido en '*'.

Nota: Le recomendamos que no configure CloudTrail para escribir en un depósito de S3 que reside en una cuenta de AWS diferente.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



