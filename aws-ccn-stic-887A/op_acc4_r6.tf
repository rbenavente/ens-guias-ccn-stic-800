resource "prismacloud_policy" "op_acc4_r6" {
   name = "Política para buckets AWS S3 demasiado permisiva para cualquier principal"
   policy_type = "config"
   cloud_type = "aws"
   severity = "medium"
   description = <<-EOT
Esta política identifica los buckets de S3 que tienen una política de demasiado permisiva para cualquier principal y no tienen habilitadas las políticas de bloqueo de acceso público. Se recomienda seguir el principio de privilegios mínimos, asegurando que solo las entidades restringidas tengan permiso para las operaciones de S3 en lugar de las anónimas.
Para más detalles: https://docs.aws.amazon.com/AmazonS3/latest/userguide/s3-bucket-user-policy-specifying-principal-intro.html
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "Política para buckets AWS S3 demasiado permisiva para cualquier principal"
        criteria= "config from cloud.resource where cloud.type = 'aws' AND api.name='aws-s3api-get-bucket-acl' AND json.rule = ( ( publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration does not exist ) or ( publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false ) or ( publicAccessBlockConfiguration.restrictPublicBuckets is false and accountLevelPublicAccessBlockConfiguration.restrictPublicBuckets is false ) or ( publicAccessBlockConfiguration does not exist and accountLevelPublicAccessBlockConfiguration does not exist ) )AND policy.Statement[?any(Effect equals Allow and Action anyStartWith s3: and (Principal.AWS contains * or Principal equals *) and (Condition does not exist or Condition[*] is empty) )] exists"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS
2. Navegue hasta el panel de S3.
3. Elija el depósito S3 informado
4. En la pestaña 'Permisos', haga clic en 'Política de depósito'
5. Actualice la política del depósito de S3 eliminando el wildcard (*) que contiene el principal para cuentas, servicios o entidades de IAM específicos. También restrinja las operaciones de acciones de S3 a específicas en lugar de usar wildcards (*).
6. En la pestaña 'Permisos', haga clic en 'Bloquear acceso público' y habilite 'Bloquear el acceso público y entre cuentas a depósitos y objetos a través de cualquier depósito público o políticas de punto de acceso'.
EOT

   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opacc4.csrs_id  # op.acc4 Compliance Section UUID

   }

}



