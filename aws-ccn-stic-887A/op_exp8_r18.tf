
resource "prismacloud_policy" "op_exp8_r18" {
   name = "AWS S3 bucket de CloudTrail no tiene activo el MFA Delete"
   policy_type = "config"
   cloud_type = "aws"
   severity = "informational"
   description = <<-EOT
Esta política identifica los depósitos de S3 que no tienen habilitada la autenticación multifactor para CloudTrails. Para el cifrado de archivos de registro, CloudTrail utiliza de forma predeterminada el cifrado del lado del servidor (SSE) de S3. Recomendamos agregar una capa adicional de seguridad agregando MFA Delete a su depósito S3. Esto ayudará a evitar la eliminación de registros de CloudTrail sin su autorización explícita. También le recomendamos que utilice una política de depósito que imponga restricciones sobre cuáles de sus usuarios de administración de acceso de identidad (IAM) pueden eliminar objetos de S3.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket de CloudTrail no tiene activo el MFA Delete"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-s3api-get-bucket-acl' as X; config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as Y; filter '($.Y.s3BucketName==$.X.bucketName) and ($.X.versioningConfiguration.mfaDeleteEnabled does not exist)'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
Habilite MFA Delete en los depósitos que haya configurado para recibir archivos de registro de CloudTrail.
Nota: Le recomendamos que no configure CloudTrail para escribir en un depósito de S3 que reside en una cuenta de AWS diferente.
Puede encontrar información adicional sobre cómo hacer esto aquí:
  http://docs.aws.amazon.com/AmazonS3/latest/dev/Versioning.html#MultiFactorAuthenticationDelete
EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



