
resource "prismacloud_policy" "op_exp8_r17" {
   name = "AWS S3 bucket de CloudTrail es de acceso público"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Esta política identifica depósitos de S3 de acceso público que almacenan datos de CloudTrail. Estos depósitos contienen datos de auditoría confidenciales y solo los usuarios y aplicaciones autorizados deben tener acceso.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket de CloudTrail es de acceso público"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name='aws-s3api-get-bucket-acl' AND json.rule = \"((((acl.grants[?(@.grantee=='AllUsers')] size > 0) or policyStatus.isPublic is true) and publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration does not exist) or ((acl.grants[?(@.grantee=='AllUsers')] size > 0) and ((publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false) or (publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false))) or (policyStatus.isPublic is true and ((publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false) or (publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false))))\" as X; config from cloud.resource where api.name = 'aws-cloudtrail-describe-trails' as Y; filter'$.X.bucketName equals $.Y.s3BucketName'; show X;"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'S3'
3. Haga clic en el recurso 'S3' informado en la alerta.
4. Haga clic en 'Permisos'
5. Si la Lista de control de acceso está configurada como "Pública", siga los pasos a continuación
a. En "Lista de control de acceso", haga clic en "Todos" y desmarque todos los elementos.
b. Haga clic en Guardar
6. Si la 'Política de depósito' está configurada como pública, siga los pasos a continuación
a. En "Política de depósito", modifique la política para eliminar el acceso público.
b. Haga clic en Guardar
C. Si no se requiere la 'Política de depósito', elimine la 'Política de depósito' existente.

Nota: Asegúrese de que la actualización de la 'Lista de control de acceso' o la 'Política de depósito' no afecte el acceso a los datos del depósito S3.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



