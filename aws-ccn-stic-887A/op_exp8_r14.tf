
resource "prismacloud_policy" "op_exp8_r14" {
   name = "AWS S3 bucket accesible publicamente con permisos de lectura"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los buckets de S3 que son accesibles públicamente mediante operaciones de  Obtener/Leer/Enumerar. Estos permisos permiten que cualquier persona, malintencionada o no, obtenga/lea/enumere el contenido del bucket S3 si puede adivinar el espacio de nombres. El servicio S3 no protege el espacio de nombres si las ACL y la política de depósito no se manejan correctamente; con esta configuración, puede correr el riesgo de comprometer datos críticos al dejar S3 público.

Para más detalles:
https://docs.aws.amazon.com/AmazonS3/latest/user-guide/set-permissions.html
https://docs.aws.amazon.com/AmazonS3/latest/dev/about-object-ownership.html#ensure-object-ownership
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket accesible publicamente con permisos de lectura"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name = 'aws-s3api-get-bucket-acl' AND json.rule = ((((publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false) or (publicAccessBlockConfiguration.ignorePublicAcls is false and accountLevelPublicAccessBlockConfiguration.ignorePublicAcls is false)) and acl.grantsAsList[?any(grantee equals AllUsers and permission is member of (ReadAcp,Read,FullControl))] exists) or ((policyStatus.isPublic is true and ((publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration does not exist) or (publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false) or (publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false))) and (policy.Statement[?any(Effect equals Allow and (Principal equals * or Principal.AWS equals *) and (Action contains s3:* or Action contains s3:Get or Action contains s3:List) and (Condition does not exist))] exists))) and websiteConfiguration does not exist"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el servicio 'S3'
3. Haga clic en el recurso S3 informado en la alerta.
4. Haga clic en la pestaña 'Permisos'
5. Si la Lista de control de acceso está configurada como "Pública", siga los pasos a continuación
a. En "Lista de control de acceso", haga clic en "Todos" y desmarque todos los elementos.
b. Haga clic en Guardar cambios
6. Si la 'Política de depósito' está configurada como pública, siga los pasos a continuación
a. En 'Política de depósito', seleccione 'Editar política de depósito' y considere definir qué 'Principal' explícito debería tener la capacidad de OBTENER/LISTAR objetos en su depósito de S3. También es posible que desee limitar específicamente la capacidad del 'Principal' para realizar funciones GET/LIST específicas, sin el comodín.
Si no se requiere la 'Política de depósito', elimine la 'Política de depósito' existente.
b. Haga clic en Guardar cambios

Nota: Asegúrese de que la actualización de la 'Lista de control de acceso' o la 'Política de depósito' no afecte el acceso a los datos del depósito S3.

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
 
}



