
resource "prismacloud_policy" "op_exp8_r16" {
   name = "AWS S3 bucket accesible publicamente a traves de ACL"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los depósitos de S3 a los que se puede acceder públicamente a través de ACL. Amazon S3 se utiliza a menudo para almacenar datos empresariales altamente confidenciales y permitir el acceso público a dicho depósito S3 a través de ACL resultaría en que los datos confidenciales se vieran comprometidos. Se recomienda encarecidamente deshabilitar la configuración de ACL para todos los depósitos de S3 y utilizar políticas basadas en recursos para permitir el acceso a los depósitos de S3.

EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket accesible publicamente a traves de ACL"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name='aws-s3api-get-bucket-acl' AND json.rule = \"((((acl.grants[?(@.grantee=='AllUsers')] size > 0) or policyStatus.isPublic is true) and publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration does not exist) or ((acl.grants[?(@.grantee=='AllUsers')] size > 0) and ((publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false) or (publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false))) or (policyStatus.isPublic is true and ((publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false) or (publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false)))) and websiteConfiguration does not exist\""
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

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



