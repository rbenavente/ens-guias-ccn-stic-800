
resource "prismacloud_policy" "op_exp8_r19" {
   name = "AWS S3 bucket no tienen cifrado del lado del servidor"
   policy_type = "config"
   cloud_type = "aws"
   severity = "low"
   description = <<-EOT
Los clientes pueden proteger los datos en los depósitos de S3 mediante el cifrado del lado del servidor de AWS. Si el cifrado del lado del servidor no está activado para los depósitos de S3 con datos confidenciales, en caso de una violación de datos, los usuarios malintencionados pueden obtener acceso a los datos.

NOTA: NO habilite esta política si está utilizando 'Cifrado del lado del servidor con claves de cifrado proporcionadas por el cliente (SSE-C)'.
EOT
   enabled = true
   labels = toset([
    "ENS",
  ])
   rule {
        name = "AWS S3 bucket no tienen cifrado del lado del servidor"
        criteria = "config from cloud.resource where cloud.type = 'aws' AND api.name= 'aws-s3api-get-bucket-acl' AND json.rule = 'policyAvailable is true and denyUnencryptedUploadsPolicies[*] is empty and sseAlgorithm equals None'"
        parameters = {
          savedSearch = false
          withIac     = false
        }
        rule_type = "Config"
        
    }
   recommendation = <<-EOT
1. Inicie sesión en la consola de AWS y navegue hasta el servicio 'S3'.
2. Haga clic en el depósito S3 informado.
3. Haga clic en la pestaña 'Propiedades'
4. En la sección "Cifrado predeterminado", elija la opción de cifrado AES-256 o AWS-KMS según sus requisitos.
Para obtener más información sobre el cifrado del lado del servidor,
Cifrado predeterminado:
https://docs.aws.amazon.com/AmazonS3/latest/dev/bucket-encryption.html
Cifrado basado en políticas:
https://docs.aws.amazon.com/AmazonS3/latest/dev/serv-side-encryption.html

EOT


   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.opexp8.csrs_id # op.exp8 Compliance Section UUID

  }
   compliance_metadata {
      compliance_id = prismacloud_compliance_standard_requirement_section.mpsi2.csrs_id # mp.si2 Compliance Section UUID

  }
 
}



